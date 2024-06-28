import app/components/items
import app/models/item.{type Item}
import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html.{div, button, input, form}

pub fn root(items: List(Item)) -> Element(t) {
  div([], [
    items.todos(items),
    todo_input()  
  ])
}

pub fn todo_input() -> Element(t) {
  form([
      attribute.attribute("hx-post", "/items/create"),
      attribute.class("flex justify-between gap-4"),
      attribute.attribute("hx-target", "#list-items"),
      attribute.attribute("hx-on::after-request", "this.reset()")
    ], 
    [
      input([
        attribute.placeholder("I need to..."), 
        attribute.class("rounded-2xl p-2"),
        attribute.id("todo_title"),
        attribute.name("todo_title"),
        attribute.attribute("type", "text"),
        attribute.attribute("min-length", "1"),
        attribute.attribute("hx-validate", "true")
      ]),
      button([
        attribute.class("rounded-2xl bg-teal-700 text-white p-2"),
        attribute.attribute("type", "submit")
      ], 
      [text("Add")]
    )
  ])
}
