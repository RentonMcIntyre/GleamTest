import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn layout(elements: List(Element(t))) -> Element(t) {
  html.html([], [
    html.head([], [
      html.title([], "Todo App in Gleam"),
      html.meta([
        attribute.name("viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1")
      ]),
      html.script([attribute.src("https://cdn.tailwindcss.com")], "text/javascript"),
      html.script([attribute.src("https://unpkg.com/htmx.org@1.9.12")], "text/javascript")
    ]),  
    html.body([attribute.class("bg-slate-300")], [
      html.nav([attribute.class("w-full flex gap-4 p-4 bg-slate-500 shadow-md")], [
        html.a([
            attribute.href("/"), attribute.class("hover:underline font-semibold")
          ], 
          [element.text("Home")]
        ),
        html.a([
            attribute.href("/complete"), attribute.class("hover:underline font-semibold")
          ], 
          [element.text("Completed")]
        )
      ]),
      html.div([
        attribute.class("flex justify-center items-center min-h-screen")], elements
      ), 
    ])
  ]) 
}
