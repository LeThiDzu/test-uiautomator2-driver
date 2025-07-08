allure.api.addPlugin({
    name: 'my-header',
    init() {
      const link = document.querySelector('.nav__title-link');
      if (link) {
        link.innerHTML = '<img src="./bhsoft_logo.ico" class="nav__title-icon">My Custom Report';
        link.href = '/test-uiautomator2-driver/';
      }
    }
  });