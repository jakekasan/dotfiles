require("jake.lazy.bootstrap")
require("lazy").setup("jake.lazy.plugins", {
  change_detection = {
    enabled = false,
    notify = false,
  },
})
