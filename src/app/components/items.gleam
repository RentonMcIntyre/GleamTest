import app/web.{type Context}
import app/models/item.{type Item, Completed, Uncompleted}
import gleam/list
import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html.{ol, li}

pub fn todos(items: List(Item)) -> Element(t) {
  ol([attribute.id("list-items")], 
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
