(function () {
  let TestDetailNewTabView = Backbone.Marionette.View.extend({
    regions: {
      videoTabs: '.tabs',
      test_result: '.test-result__content'
    },
    template: function () {
      return `
        <div class="video-container"></div>
      `;
    },
    onRender: function () {
      const testName = this.model.get('name');
      const videoName = testName.replace(/\s/g, "_");
      const testStatus = this.model.get('status');

      if (testStatus !== "failed") {
        this.$('.video-container').append(`<p>No video available (test did not fail).</p>`);
        return;
      }

      const basePath = window.location.origin + window.location.pathname.split('/').slice(0, -1).join('/');
      const videoUrl = `${basePath}/Videos/${videoName}.mp4`;

      this.$('.video-container').append(`
        <video class="responsive-video" controls>
          <source src="${videoUrl}" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      `);
    }
  });

  allure.api.addTestResultTab('test-video', 'Test video Tab', TestDetailNewTabView);
})();
