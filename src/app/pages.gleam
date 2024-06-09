import app/pages/home
import app/models/item.{type Item}

pub fn home(items: List(Item)) {
  home.root(items)
}
