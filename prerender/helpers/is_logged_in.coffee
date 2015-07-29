isLoggedIn = ({cookies}) ->
  cookies.top_logged_in?

module.exports = isLoggedIn
