(function () {
  let TestDetailNewTabView = Backbone.Marionette.View.extend({
    regions: {
      videoTabs: '.tabs',
      test_result: '.test-result__content'
    },
    template: function () {
      return `
        <div id="test-name"></div>
        <div id="test-status"></div>
        <div class="video-container"></div>
      `;
    },
    onRender: function () {
      const testName = this.model.get('name');
      const videoName = testName.replace(/\s/g, "_")
      const uuid = this.model.get('uuid');
      const test_status = this.model.get('status')
      const pathSegments = window.location.pathname.split('/');
      const androidVer = pathSegments[pathSegments.length - 2];
      this.$('#test-name').append(`<h2>${testName}</h2>`)
      this.$('#test-status').append(`Status: ${test_status}`)
      this.$('.video-container').append(`<video src="${androidVer}/Videos/${videoName}.mp4" controls></video>`);
    }
  })
  allure.api.addTestResultTab('test-video', 'Test video Tab', TestDetailNewTabView)

  let VideoTabView = Backbone.Marionette.View.extend({
    regions: {
      test_result: '.test-result__content'
    },
    template: function () {
      return `
          <h2>Test Videos</h2>
          <div ng-repeat="test in testVideos">
              <h4>{{test.name}}</h4>
              <video width="640" height="360" controls ng-if="test.videoUrl">
              <source ng-src="{{trustSrc(test.videoUrl)}}" type="video/mp4">
              Your browser does not support the video tag.
              </video>
              <p ng-if="!test.videoUrl">No video available.</p>
              <hr>
          </div>
      `
    }
  })
})()