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
      const basePath = window.location.origin + window.location.pathname.split('/').slice(0, -1).join('/');
      const videoUrl = `${basePath}/Videos/${videoName}.mp4`;
      this.$('#test-name').append(`<h2>${testName}</h2>`);
      this.$('#test-status').append(`Status: ${testStatus}`);
      this.$('.video-container').append(`
        <video width="640" controls>
          <source src="${videoUrl}" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      `);
    }
  })
  allure.api.addTestResultTab('test-video', 'Test video Tab', TestDetailNewTabView)
})()