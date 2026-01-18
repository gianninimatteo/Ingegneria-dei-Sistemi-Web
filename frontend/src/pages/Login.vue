<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"

export default defineComponent({
  data() {
    return {
      username: "",
      password: "",
    }
  },
  methods: {
    async onSubmit() {
      try {
        await axios.post("http://localhost:3000/api/auth/login", {
          username: this.username,
          password: this.password,
        }, {
          withCredentials: true
        })
        this.$router.push("/")
      } catch (e: any) {
        if (e.response) {
          alert(`${e.response.status} - ${e.response.statusText}\n${e.response.data}`)
        } else {
          alert(e.message)
        }
      }
    },
  },
})
</script>

<template>
  <div>
    <header>
      <div class="header-content">
        <div class="line">
          <span class="gamenest">GAMENEST</span>
          <img src="/icons/logo.png" alt="Logo" class="logo" />
        </div>
        <div class="shop">SHOP</div>
      </div>
    </header>
    
    <main>
      <h2>Login</h2>
      <form @submit.prevent="onSubmit">
        <div>
          <label>Username</label>
          <input
            type="text"
            v-model="username"
            required
          />
        </div>
        
        <div>
          <label>Password</label>
          <input
            type="password"
            v-model="password"
            required
          />
        </div>

        <p>Non hai un account? <router-link to="/register" class="link">Registrati</router-link></p>
        
        <button type="submit">Accedi</button>
      </form>
    </main>
  </div>
</template>

<style scoped>
header {
  background-color: #35373D;
  color: white;
  padding: 0.5rem;
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

h2 {
  color: white;
   margin-bottom: 1.5rem;
}

main {
  max-width: 500px;
  margin: 2rem auto;
  padding: 2rem;
}

form div {
  margin-bottom: 1rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  color: white;
}

input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 8px;
}

p {
  color: white;
  text-align: right
}

.link {
  color: white;
  font-weight: bold;
}

button {
  width: 50%;
  display: block;
  margin: 0 auto;
  padding: 0.75rem;
  background-color: white;
  color: black;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-top: 1.5rem;
}

button:hover {
  background-color: #EFEFF0;
}
</style>
