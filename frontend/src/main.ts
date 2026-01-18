import { createApp } from "vue"
import { createRouter, createWebHistory, type Router } from "vue-router"
import "./style.css"
import App from "./App.vue"
import Home from "./pages/Home.vue"
import ProssimeUscite from "./pages/ProssimeUscite.vue"
import Console from "./pages/Console.vue"
import DettaglioGioco from "./pages/DettaglioGioco.vue"
import Carrello from "./pages/Carrello.vue"
import Checkout from "./pages/Checkout.vue"
import Libreria from "./pages/Libreria.vue"
import Login from "./pages/Login.vue"
import Register from "./pages/Register.vue"
import NotFound from "./pages/NotFound.vue"

const router: Router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", component: Home },
    { path: "/prossime-uscite", component: ProssimeUscite },
    { path: "/console/:nome", component: Console },
    { path: "/gioco/:id", component: DettaglioGioco },
    { path: "/carrello", component: Carrello },
    { path: "/checkout", component: Checkout },
    { path: "/libreria", component: Libreria },
    { path: "/login", component: Login },
    { path: "/register", component: Register },
    { path: "/:pathMatch(.*)*", component: NotFound }
  ]
})

createApp(App)
  .use(router)
  .mount("#app")
