<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"
import type { Acquisto } from "../types"

export default defineComponent({
  data() {
    return {
      acquisti: [] as Acquisto[]
    }
  },
  async mounted() {
    try {
      const response = await axios.get("http://localhost:3000/api/libreria", {
        withCredentials: true
      })
      this.acquisti = response.data
    } catch (e: any) {
      if (e.response) {
        alert(`${e.response.status} - ${e.response.statusText}\n${e.response.data}`)
      } else {
        alert(e.message)
      }
    }
  }
})
</script>

<template>
  <div class="libreria-container">
    <h1>La mia Libreria</h1>

    <div v-if="acquisti.length === 0" class="empty-message">
      <p>Non hai ancora acquistato nessun gioco.</p>
    </div>

    <div v-else class="giochi-lista">
      <div v-for="acquisto in acquisti" :key="acquisto.id" class="gioco-card">
        <img :src="`http://localhost:3000/img/${acquisto.gioco.immagine_url}`" :alt="acquisto.gioco.titolo" />
        <div class="gioco-info">
          <h2>{{ acquisto.gioco.titolo }}</h2>
          <p class="piattaforma">{{ acquisto.gioco.piattaforma }}</p>
          <p class="data-acquisto">Acquistato il: {{ new Date(acquisto.data_acquisto).toLocaleDateString('it-IT') }}</p>

          <div v-if="acquisto.codice_attivazione">
            <div class="installazione-info">
              <p>{{ acquisto.gioco.installazione }}</p>
            </div>

            <div class="codice-attivazione">
              <strong>Codice di attivazione:</strong>
              <span class="codice">{{ acquisto.codice_attivazione }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.libreria-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

h1 {
  font-size: 2.5rem;
  margin-bottom: 30px;
  color: white;
  text-align: center;
}

.empty-message {
  text-align: center;
  padding: 50px;
  font-size: 1.2rem;
  color: white;
}

.giochi-lista {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 30px;
}

.gioco-card {
  background: white;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  transition: transform 0.2s;
}

.gioco-card:hover {
  transform: scale(1.05);
}

.gioco-card img {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.gioco-info {
  padding: 20px;
}

.gioco-info h2 {
  font-size: 1.5rem;
  margin-bottom: 10px;
  color: #222;
}

.piattaforma {
  color: #666;
  font-weight: bold;
  margin-bottom: 10px;
}

.data-acquisto {
  color: #888;
  font-size: 0.9rem;
  margin-bottom: 15px;
}

.installazione-info {
  background: #f9f9f9;
  padding: 12px;
  border-radius: 6px;
  margin-bottom: 15px;
  border-left: 4px solid #3498db;
}

.installazione-info p {
  margin: 0;
  color: #555;
  line-height: 1.5;
}

.codice-attivazione {
  background: #f0f8ff;
  padding: 15px;
  border-radius: 8px;
  border: 2px solid #4a90e2;
}

.codice-attivazione strong {
  display: block;
  margin-bottom: 8px;
  color: #333;
}

.codice {
  display: block;
  font-family: 'Courier New', monospace;
  font-size: 1.2rem;
  font-weight: bold;
  color: #4a90e2;
  letter-spacing: 2px;
  user-select: all;
}
</style>
