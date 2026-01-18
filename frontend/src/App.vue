<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"
import type { User } from "./types"

export default defineComponent({
  data() {
    return {
      user: null as User | null
    }
  },
  computed: {
    isAuthPage() {
      return this.$route.path === '/login' || this.$route.path === '/register'
    }
  },
  async mounted() {
    if (!this.isAuthPage) {
      await this.caricaUtente()
    }
  },
  watch: {
    '$route'() {
      if (!this.isAuthPage) {
        this.caricaUtente() //quando l'url cambia (da login/registrazione) esegue caricaUtente (prende username e ruolo dal server)
      }
    }
  },
  methods: {
    async caricaUtente() {
      try {
        const response = await axios.get("http://localhost:3000/api/auth/profile", {
          withCredentials: true
        })
        this.user = response.data
      } catch (e) {
        console.error(e)
      }
    },
    async logout() {
      try {
        await axios.post("http://localhost:3000/api/auth/logout", {}, {
          withCredentials: true
        })
        this.user = null //tutte le volte che si fa logout azzera 'user'
        this.$router.push("/login")
      } catch (e) {
        console.error(e)
      }
    }
  }
})
</script>

<template>
  <div id="app">
    <header v-if="!isAuthPage">
      <div class="header-content">
        <div class="line">
          <span class="gamenest">GAMENEST</span>
          <img src="/icons/logo.png" alt="Logo" class="logo" />
        </div>
        <div class="shop">SHOP</div>
      </div>
      <nav>
        <router-link to="/">Tendenze</router-link>
        <router-link to="/prossime-uscite">Prossime uscite</router-link>
      </nav>
      <div class="icons">
        <router-link to="/libreria"><img src="/icons/libreria.png" alt="libreria"> Libreria</router-link>
        <router-link to="/carrello"><img src="/icons/carrello.png" alt="carrello"> Carrello</router-link>
        <span v-if="user" :class="{ 'username': true, 'admin': user.role === 'admin', 'normal': user.role !== 'admin' }"><img src="/icons/utente.png" alt="utente">{{ user.username }}</span>
        <button @click="logout"><img src="/icons/logout.png" alt="logout">Logout</button>
      </div>
    </header>

    <router-view />

    <footer v-if="!isAuthPage">
      <p>Copyright @ 2026 - Gamenest Shop - All rights reserved</p>
    </footer>
  </div>
</template>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, sans-serif;
  background-color: #686D77;
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

header {
  background-color: #35373D;
  color: white;
  padding: 0.5rem;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
}

header nav {
  justify-self: center;
}

.icons {
  justify-self: end;
}

.line {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.gamenest {
  font-size: 2rem;
  font-weight: bold;
}

.logo {
  height: 40px;
  width: auto;
}

.shop {
  font-size: 2rem;
  font-weight: bold;
}

header nav a {
  color: white;
  margin: 0 1rem;
  text-decoration: none;
}

header nav a:hover,
header nav a.router-link-active {
  text-decoration: underline;
}

.icons img {
  width: 20px;
  vertical-align: middle;
}

.icons a, .icons button {
  color: white;
  margin-left: 1rem;
  background: none;
  border: none;
  cursor: pointer;
  text-decoration: none;
}

.icons button {
  font-size: 1rem;
}

.username {
  margin-left: 1rem;
  font-weight: bold;
  font-size: 1.1rem;
}

.username.admin {
  color: #ff69b4;
}

.username.normal {
  color: #4DA5DF;
}

footer {
  background-color: #35373D;
  color: white;
  text-align: center;
  padding: 1rem;
  margin-top: auto;
}

@media screen and (max-width: 768px) {
  header {
    grid-template-columns: 1fr;
    grid-template-rows: auto auto auto;
    gap: 1rem;
  }

  .header-content {
    justify-self: center;
  }

  header nav {
    justify-self: center;
  }

  .icons {
    justify-self: center;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 0.5rem;
  }

  .gamenest {
    font-size: 1.5rem;
  }

  .shop {
    font-size: 1.5rem;
  }
}
</style>
