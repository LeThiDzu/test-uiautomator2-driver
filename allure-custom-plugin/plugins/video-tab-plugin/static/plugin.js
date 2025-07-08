(function () {
    let TestDetailNewTabView = Backbone.Marionette.View.extend({
        template: function () {
            return `
                <div class="test-video-container">
                    <h3>Test Video</h3>
                    <div class="video-player"></div>
                    <p class="video-status"></p>
                </div>
            `;
        },

        onRender: function () {
            const testName = this.model.get('name');
            const testStatus = this.model.get('status');
            const attachments = this.model.get('attachments') || [];

            const videoAttachment = attachments.find(att => att.type && att.type.startsWith('video/'));
            if (videoAttachment) {
                const videoFileName = testName.replace(/\s/g, "_") + '.mp4';
                const videoUrl = `data/${videoAttachment.source}`;

                this.$('.video-player').html(`
                    <video width="100%" controls>
                      <source src="${videoUrl}" type="video/mp4">
                      Trình duyệt của bạn không hỗ trợ thẻ video.
                    </video>
                `);
                this.$('.video-status').text(`Trạng thái test: ${testStatus.toUpperCase()}`);
            } else {
                this.$('.test-video-container').html(`
                    <p>Không tìm thấy video được ghi lại cho bài kiểm thử này.</p>
                `);
            }
        },
        onDestroy: function() {
            console.log("TestDetailNewTabView destroyed.");
        }
    });

    allure.api.controller('TestVideoTabController', function($scope, $element, $timeout) {
        const testcaseModel = new Backbone.Model($scope.testcase);

        const marionetteView = new TestDetailNewTabView({
            model: testcaseModel,
            el: $element[0]
        });

        marionetteView.render();

        $scope.$on('$destroy', function() {
            if (marionetteView && typeof marionetteView.destroy === 'function') {
                marionetteView.destroy();
            } else if (marionetteView && typeof marionetteView.remove === 'function') {
                marionetteView.remove();
            }
        });
    });

    allure.api.addTestcaseBlock({
        title: 'Test Record',
        template: 'video-tab-template.html',
        controller: 'TestVideoTabController',
        order: 50,
        factory: function(testcase) {
            const hasVideo = testcase.attachments.some(att => att.type && att.type.startsWith('video/'));
            return testcase.status === 'failed' && hasVideo;
        }
    });
})()