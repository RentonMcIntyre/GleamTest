import app/models/item.{type Item, Completed, Uncompleted}
import gleam/list
import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html.{ol, li, button, span}

pub fn todos(items: List(Item)) -> Element(t) {
  ol([attribute.id("list-items"), attribute.class("flex flex-col gap-2 mb-4")], 
      items
        |> list.map(item),
  )
}

pub fn item(item: Item) -> Element(t) {
  let completed_class: String = {
    case item.status {
      Completed -> "line-through"
      Uncompleted -> ""
    }
  }
  let item_text: String = {
    case item.status {
      Completed -> "O"
      Uncompleted -> "X"
    }
  }
  
  li([attribute.class("flex justify-between")], 
  [
    span([attribute.class(completed_class)],[text(item.title)]),
    button([
        attribute.class("rounded-full flex justify-center items-center w-8 h-8 bg-emerald-600 text-neutral-600 hover:bg-emerald-900 hover:text-neutral-200"),
        attribute.attribute("hx-target", "#list-items"),
        attribute.attribute("hx-get", "/items/toggle/" <> item.id)
      ],
      [text(item_text)]
    )
  ])
}
