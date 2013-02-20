$ ->
  activeTab = $('[href=' + location.hash + ']')
  activeTab and activeTab.tab('show')