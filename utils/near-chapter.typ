#let near-chapter = context {
  let headings_after = query(selector(heading.where(level: 1)).after(here()))
  let headings_before = query(selector(heading.where(level: 1)).before(here()))
  let headings_before_tbl = query(selector(heading.where(level: 1)).before(heading.where(level: 1, body: [表目录])))
  let headings_before_ref = query(selector(heading.where(level: 1)).before(heading.where(level: 1, body: [参考文献])))
  

  if headings_after.len() == 0 {
    return
  }

  let heading = headings_after.first()
  if heading.location().page() > here().page() {
    if headings_before.len() == 0 {
      return
    }
    if headings_before.len() < headings_before_tbl.len() + 1 {
      return headings_before.last().body
    }
    if headings_before.len() >= headings_before_ref.len() {
      return headings_before.last().body
    }
    return [#(headings_before.len() - headings_before_tbl.len())] + h(0.5em) + headings_before.last().body
  } else {
    if headings_before.len() < headings_before_tbl.len() {
      return heading.body
    }
    if headings_before.len() >= headings_before_ref.len() - 1 {
      return heading.body
    }
    return [#(headings_before.len() + 1 - headings_before_tbl.len())] + h(0.5em) + heading.body
  }
}
