import app/models/item.{type Item, Completed, Uncompleted}
import gleam/list
import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html.{h1, div, ol, li, button, input}

pub fn root(items: List(Item)) -> Element(t) {
  div([], [
    todos(items),
    todo_input()  
  ])
}

pub fn todos(items: List(Item)) -> Element(t) {
  ol([], 
      items
        |> list.map(item),
  )
}

pub fn item(item: Item) -> Element(t) {
  let completed_class: String = {
    case item.status {
      Completed -> "strikethrough"
      Uncompleted -> ""
    }
  }
  
  li([attribute.class(completed_class)], [text(item.title)])
}

pub fn todo_input() -> Element(t) {
  div([attribute.class("flex justify-between gap-4")], [
    input([attribute.placeholder("I need to..."), attribute.class("rounded-2xl p-2")]),
    button([
        attribute.class("rounded-2xl bg-teal-700 text-white p-2"),
        attribute.attribute("hx-post", "/create"),
      ], 
      [text("Add")]
    )
  ])
}
