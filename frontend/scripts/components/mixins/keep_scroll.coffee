KeepScroll =
  keepScroll: (fn) ->
    {scrollX, scrollY} = window
    fn()
    window.scrollTo scrollX, scrollY

module.exports = KeepScroll
