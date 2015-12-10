!do ->
  d = 
    version: '1.6.19'
    mesh: (n) ->
      u n, r.apply(this, arguments)
    meshArcs: r
    merge: (n) ->
      u n, e.apply(this, arguments)
    mergeArcs: e
    feature: o
    neighbors: a
    presimplify: s

  t = (n, t) ->
    o = {}
    i = {}
    u = {}
    f = []
    c = -1

    r = (t) ->
      `var o`
      `var r`
      r = undefined
      e = n.arcs[if 0 > t then ~t else t]
      o = e[0]
      if n.transform then r = [
        0
        0
      ]
      e.forEach(((n) ->
        r[0] += n[0]
        r[1] += n[1]
        return
      ))
 else (r = e[e.length - 1])
      if 0 > t then [
        r
        o
      ] else [
        o
        r
      ]

    e = (n, t) ->
      `var e`
      `var r`
      for r of n
        e = n[r]
        delete t[e.start]
        delete e.start
        delete e.end
        e.forEach((n) ->
          o[if 0 > n then ~n else n] = 1
          return
        )
        f.push(e)
      return

    t.forEach((r, e) ->
      `var i`
      `var o`
      o = undefined
      i = n.arcs[if 0 > r then ~r else r]
      i.length < 3 and !i[1][0] and !i[1][1] and o = t[++c]
      t[c] = r
      t[e] = o
      return
    )
    t.forEach((n) ->
      `var c`
      `var f`
      `var o`
      `var e`
      `var t`
      t = undefined
      e = undefined
      o = r(n)
      f = o[0]
      c = o[1]
      if t = u[f]
        if delete u[t.end]
          t.push(n)
          t.end = c
          e = i[c]

          delete i[e.start]
          a = if e == t then t else t.concat(e)
          i[a.start = t.start] = u[a.end = e.end] = a
        else
          i[t.start] = u[t.end] = t
      else if t = i[c]
        if delete i[t.start]
          t.unshift(n)
          t.start = f
          e = u[f]

          delete u[e.end]
          s = if e == t then t else e.concat(t)
          i[s.start = e.start] = u[s.end = t.end] = s
        else
          i[t.start] = u[t.end] = t
      else
        t = [ n ]
        i[t.start = f] = u[t.end = c] = t
      return
    )
    e(u, i)
    e(i, u)
    t.forEach((n) ->
      o[if 0 > n then ~n else n] or f.push([ n ])
      return
    )
    f

  r = (n, r, e) ->
    c = []

    o = (n) ->
      `var t`
      t = if 0 > n then ~n else n
      (s[t] or (s[t] = [])).push
        i: n
        g: a
      return

    i = (n) ->
      n.forEach o
      return

    u = (n) ->
      n.forEach i
      return

    f = (n) ->
      if 'GeometryCollection' == n.type then n.geometries.forEach(f) else n.type of l and a = n
      l[n.type](n.arcs)
      return

    if arguments.length > 1
      a = undefined
      s = []
      l = 
        LineString: i
        MultiLineString: u
        Polygon: u
        MultiPolygon: (n) ->
          n.forEach u
          return
      f(r)
      s.forEach(if arguments.length < 3 then ((n) ->
        c.push n[0].i
        return
      ) else ((n) ->
        e(n[0].g, n[n.length - 1].g) and c.push(n[0].i)
        return
      ))
    else
      h = 0
      p = n.arcs.length
      while p > h
        c.push h
        ++h
    {
      type: 'MultiLineString'
      arcs: t(n, c)
    }

  e = (r, e) ->
    f = {}
    c = []
    a = []

    o = (n) ->
      n.forEach((t) ->
        t.forEach (t) ->
          (f[t = if 0 > t then ~t else t] or (f[t] = [])).push n
          return
        return
      )
      c.push(n)
      return

    i = (n) ->
      l(u(r,
        type: 'Polygon'
        arcs: [ n ]).coordinates[0]) > 0

    e.forEach((n) ->
      if 'Polygon' == n.type then o(n.arcs) else 'MultiPolygon' == n.type and n.arcs.forEach(o)
      return
    )
    c.forEach((n) ->
      `var r`
      `var t`
      if !n._
        t = []
        r = [ n ]
        n._ = 1
        a.push(t)
        while n = r.pop()
          t.push(n)
          n.forEach((n) ->
            n.forEach (n) ->
              f[if 0 > n then ~n else n].forEach (n) ->
                n._ or n._ = 1
                r.push(n)
                return
              return
            return
          )
      return
    )
    c.forEach((n) ->
      delete n._
      return
    )

      type: 'MultiPolygon'
      arcs: a.map((e) ->
        `var o`
        o = []
        if e.forEach(((n) ->
            `var a`
            `var c`
            n.forEach ((n) ->
              n.forEach ((n) ->
                f[(if 0 > n then ~n else n)].length < 2 and o.push(n)
                return
              )
              return
            )
            return
          ))
          o = t(r, o)
          (n = o.length) > 1

          u = undefined
          c = i(e[0][0])
          a = 0
          while n > a
            if c == i(o[a])
              u = o[0]
              o[0] = o[a]
              o[a] = u
              break
            ++a
        o
      )

  o = (n, t) ->
    if 'GeometryCollection' == t.type then
      type: 'FeatureCollection'
      features: t.geometries.map(((t) ->
        i n, t
      )) else i(n, t)

  i = (n, t) ->
    `var r`
    r = 
      type: 'Feature'
      id: t.id
      properties: t.properties or {}
      geometry: u(n, t)
    null == t.id and delete r.id
    r

  u = (n, t) ->
    a = v(n.transform)
    s = n.arcs
    l = 
      Point: (n) ->
        e n.coordinates
      MultiPoint: (n) ->
        n.coordinates.map e
      LineString: (n) ->
        o n.arcs
      MultiLineString: (n) ->
        n.arcs.map o
      Polygon: (n) ->
        u n.arcs
      MultiPolygon: (n) ->
        `var r`
        n.arcs.map u

    r = (n, t) ->
      `var e`
      `var i`
      `var o`
      `var e`
      `var r`
      t.length and t.pop()
      r = undefined
      e = s[if 0 > n then ~n else n]
      o = 0
      i = e.length
      while i > o
        t.push(r = e[o].slice())
        a(r, o)
        ++o
      0 > n and f(t, i)
      return

    e = (n) ->
      `var o`
      n = n.slice()
      a(n, 0)
      n

    o = (n) ->
      `var i`
      `var o`
      `var e`
      `var t`
      t = []
      e = 0
      o = n.length
      while o > e
        r n[e], t
        ++e
      t.length < 2 and t.push(t[0].slice())
      t

    i = (n) ->
      `var u`
      `var t`
      t = o(n)
      while t.length < 4
        t.push t[0].slice()
      t

    u = (n) ->
      n.map i

    c = (n) ->
      `var t`
      t = n.type
      if 'GeometryCollection' == t then
        type: t
        geometries: n.geometries.map(c) else if t of l then
        type: t
        coordinates: l[t](n) else null

    c t

  f = (n, t) ->
    `var o`
    `var e`
    `var r`
    r = undefined
    e = n.length
    o = e - t
    while o < --e
      r = n[o]
      n[o++] = n[e]
      n[e] = r
    return

  c = (n, t) ->
    `var o`
    `var e`
    `var r`
    r = 0
    e = n.length
    while e > r
      o = r + e >>> 1
      if n[o] < t then (r = o + 1) else (e = o)
    r

  a = (n) ->
    `var i`
    `var o`
    o = {}
    i = n.map(->
      `var u`
      []
    )
    u = 
      LineString: t
      MultiLineString: r
      Polygon: r
      MultiPolygon: (n, t) ->
        `var t`
        n.forEach (n) ->
          r n, t
          return
        return

    t = (n, t) ->
      `var r`
      n.forEach (n) ->
        `var r`
        0 > n and (n = ~n)
        r = o[n]
        if r then r.push(t) else (o[n] = [ t ])
        return
      return

    r = (n, r) ->
      `var e`
      n.forEach (n) ->
        t n, r
        return
      return

    e = (n, t) ->
      `var a`
      `var f`
      if 'GeometryCollection' == n.type then n.geometries.forEach(((n) ->
        e n, t
        return
      )) else n.type of u and u[n.type](n.arcs, t)
      return

    n.forEach e
    for f of o
      a = o[f]
      s = a.length
      l = 0
      while s > l
        h = l + 1
        while s > h
          p = undefined
          g = a[l]
          v = a[h]
          (p = i[g])[f = c(p, v)] != v and p.splice(f, 0, v)
          (p = i[v])[f = c(p, g)] != g and p.splice(f, 0, g)
          ++h
        ++l
    i

  s = (n, t) ->
    `var r`
    `var i`
    `var o`
    `var e`
    e = v(n.transform)
    o = m(n.transform)
    i = g()

    r = (n) ->
      i.remove(n)
      n[1][2] = t(n)
      i.push(n)
      return

    t or (t = h)
    n.arcs.forEach((n) ->
      `var l`
      `var s`
      `var l`
      `var s`
      `var s`
      `var a`
      `var c`
      `var f`
      `var u`
      u = undefined
      f = undefined
      c = []
      a = 0
      s = 0
      l = n.length
      while l > s
        f = n[s]
        e(n[s] = [
          f[0]
          f[1]
          1 / 0
        ], s)
        ++s
      while l > s
        u = n.slice(s - 1, s + 2)
        u[1][2] = t(u)
        c.push(u)
        i.push(u)
        ++s
      while l > s
        u = c[s]
        u.previous = c[s - 1]
        u.next = c[s + 1]
        ++s
      while u = i.pop()
        h = u.previous
        p = u.next
        if u[1][2] < a then (u[1][2] = a) else (a = u[1][2])
        h and h.next = p
        h[2] = u[2]
        r(h)

        p and p.previous = h
        p[0] = u[0]
        r(p)

      n.forEach o
      return
    )
    n

  l = (n) ->
    `var i`
    `var o`
    `var e`
    `var r`
    `var t`
    t = undefined
    r = -1
    e = n.length
    o = n[e - 1]
    i = 0
    while ++r < e
      t = o
      o = n[r]
      i += t[0] * o[1] - (t[1] * o[0])
    .5 * i

  h = (n) ->
    `var e`
    `var r`
    `var t`
    t = n[0]
    r = n[1]
    e = n[2]
    Math.abs (t[0] - (e[0])) * (r[1] - (t[1])) - ((t[0] - (r[0])) * (e[1] - (t[1])))

  p = (n, t) ->
    n[1][2] - (t[1][2])

  g = ->
    `var o`
    `var e`
    `var r`
    r = {}
    e = []
    o = 0

    n = (n, t) ->
      `var t`
      `var o`
      `var r`
      while t > 0
        r = (t + 1 >> 1) - 1
        o = e[r]
        if p(n, o) >= 0
          break
        e[o._ = t] = o
        e[n._ = t = r] = n
      return

    t = (n, t) ->
      `var f`
      `var u`
      `var i`
      `var r`
      loop
        r = t + 1 << 1
        i = r - 1
        u = t
        f = e[u]
        if o > i and p(e[i], f) < 0 and (f = e[u = i])
          o > r and p(e[r], f) < 0 and (f = e[u = r])
          u == t

          break
        e[f._ = t] = f
        e[n._ = t = u] = n
      return

    r.push = (t) ->
      n(e[t._ = o] = t, o++)
      o

r.pop = ->
      `var r`
      `var n`
      if !(0 >= o)
        n = undefined
        r = e[0]
        return --o > 0 and n = e[o]
        t(e[n._ = 0] = n, 0)

        r

      return

r.remove = (r) ->
      `var u`
      `var i`
      i = undefined
      u = r._
      if e[u] == r
        return u != --o and i = e[o]
        (if p(i, r) < 0 then n else t)(e[i._ = u] = i, u)

        u

      return

r

  v = (n) ->
    `var u`
    `var i`
    `var o`
    `var e`
    `var r`
    `var t`
    if !n
      return y
    t = undefined
    r = undefined
    e = n.scale[0]
    o = n.scale[1]
    i = n.translate[0]
    u = n.translate[1]
    (n, f) ->
      f or (t = r = 0)
      n[0] = (t += n[0]) * e + i
      n[1] = (r += n[1]) * o + u
      return

  m = (n) ->
    `var u`
    `var i`
    `var o`
    `var e`
    `var r`
    `var t`
    if !n
      return y
    t = undefined
    r = undefined
    e = n.scale[0]
    o = n.scale[1]
    i = n.translate[0]
    u = n.translate[1]
    (n, f) ->
      `var a`
      `var c`
      f or (t = r = 0)
      c = (n[0] - i) / e | 0
      a = (n[1] - u) / o | 0
      n[0] = c - t
      n[1] = a - r
      t = c
      r = a
      return

  y = ->

  if 'function' == typeof define and define.amd then define(d) else if 'object' == typeof module and module.exports then (module.exports = d) else (@topojson = d)
  return

# ---
# generated by js2coffee 2.1.0