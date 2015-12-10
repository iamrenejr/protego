cheerio = require 'cheerio'
$ = cheerio.load '<body></body>'

d3 = require 'd3'
oboe = require 'oboe'

svg = d3.select $
.append 'svg'
.attr 'width', width
.attr 'height', height

console.log svg