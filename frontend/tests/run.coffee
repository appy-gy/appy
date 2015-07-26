setup = require '../scripts/setup'
setup()

context = require.context '.', true, /_test$/
context.keys().each(context)
