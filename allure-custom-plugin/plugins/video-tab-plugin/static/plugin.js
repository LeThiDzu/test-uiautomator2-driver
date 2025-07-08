(function () {
  const testStatus
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
      testStatus = this.model.get('status');
      const videoName = testName.replace(/\s/g, "_")
      const basePath = window.location.origin + window.location.pathname.split('/').slice(0, -1).join('/');
      const videoUrl = `${basePath}/Videos/${videoName}.mp4`;
      this.$('.video-container').append(`
        <video width="640" controls>
          <source src="${videoUrl}" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      `);
    }
  })

  if (testStatus === 'failed') {
    allure.api.addTestResultTab('test-video', 'Test video Tab', TestDetailNewTabView)
  }
})()