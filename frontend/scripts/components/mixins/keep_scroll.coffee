KeepScroll =
  keepScroll: (fn) ->
    {scrollTop} = document.body
    fn()
    document.body.scrollTop = scrollTop

module.exports = KeepScroll
