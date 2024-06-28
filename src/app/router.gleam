import app/components/items
import app/pages
import app/pages/layout.{layout}
import app/routes/item_routes.{items_middleware}
import app/web.{type Context}
import lustre/element
import gleam/http
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use req <- web.middleware(req, ctx)
  use ctx <- items_middleware(req, ctx)

  case wisp.path_segments(req) {
    [] -> {
      [pages.home(ctx.items)]
      |> layout
      |> element.to_document_string_builder
      |> wisp.html_response(200)
    }
    ["items"] -> {
      use <- wisp.require_method(req, http.Get)
      items.todos(ctx.items)
      |> element.to_document_string_builder
      |> wisp.html_response(200)
    }
    ["items", "create"] -> {
      use <- wisp.require_method(req, http.Post)
      item_routes.post_create_item(req, ctx)
    }
    ["items", "toggle", id] -> {
      use <- wisp.require_method(req, http.Get)
      item_routes.toggle_completion(req, id, ctx)
    }
    ["internal-server-error"] -> wisp.internal_server_error()
    ["unprocessable-entity"] -> wisp.unprocessable_entity()
    ["method-not-allowed"] -> wisp.method_not_allowed([])
    ["entity-too-large"] -> wisp.entity_too_large()
    ["bad-request"] -> wisp.bad_request()
    _ -> wisp.not_found()
  }
}
