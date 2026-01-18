<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"
import type { Gioco } from "../types"

export default defineComponent({
  data() {
    return {
      giochi: [] as Gioco[],
      consoleSelezionata: "Tutte",
    }
  },
  async mounted() {
    await this.caricaGiochi()
  },
  computed: {
    giochiFiltrati(): Gioco[] {
      if (this.consoleSelezionata === "Tutte") {
        return this.giochi
      }
      return this.giochi.filter(g => g.piattaforma === this.consoleSelezionata)
    }
  },
  methods: {
    async caricaGiochi() {
      try {
        const response = await axios.get("http://localhost:3000/api/tendenze", {
          withCredentials: true
        })
        this.giochi = response.data
      } catch (e: any) {
        console.error(e)
        alert("Errore nel caricamento dei giochi")
      }
    },
    selezionaConsole(console: string) {
      this.consoleSelezionata = console
    },
    vaiADettaglio(id: number) {
      this.$router.push(`/gioco/${id}`)
    }
  }
})
</script>

<template>
  <div class="home-page">
    <div class="filtri-console">
      <button @click="selezionaConsole('Tutte')" :class="{ active: consoleSelezionata === 'Tutte' }"><img src="/icons/tutti.png" alt="tutti">Tutti</button>
      <button @click="selezionaConsole('PC')" :class="{ active: consoleSelezionata === 'PC' }"><img src="/icons/pc.png" alt="PC"> PC</button>
      <button @click="selezionaConsole('PlayStation')" :class="{ active: consoleSelezionata === 'PlayStation' }"><img src="/icons/playstation.png" alt="playstation"> PlayStation</button>
      <button @click="selezionaConsole('Xbox')" :class="{ active: consoleSelezionata === 'Xbox' }"><img src="/icons/xbox.png" alt="xbox"> Xbox</button>
      <button @click="selezionaConsole('Nintendo')" :class="{ active: consoleSelezionata === 'Nintendo' }"><img src="/icons/nintendo.png" alt="nintendo"> Nintendo</button>
    </div>

    <main class="giochi-grid">
      <div 
        v-for="gioco in giochiFiltrati" 
        :key="gioco.id" 
        class="gioco-card"
        @click="vaiADettaglio(gioco.id)"
      >
        <img :src="`http://localhost:3000/img/${gioco.immagine_url}`" :alt="gioco.titolo">
        <h3>{{ gioco.titolo }}</h3>
        <p class="piattaforma">{{ gioco.piattaforma }}</p>
        <p class="prezzo">{{ gioco.prezzo }} €</p>
      </div>
    </main>
  </div>
</template>

<style scoped>
.home-page {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.filtri-console {
  background-color: #35373D;
  padding: 1rem;
  text-align: center;
  margin: auto;
  margin-top: 10px;
  border-radius: 20px;
}

.filtri-console button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  margin: 0 0.5rem;
  border-radius: 5px;
  cursor: pointer;
}

.filtri-console button:hover,
.filtri-console button.active {
  background-color: #2980b9;
}

button img {
  width: 20px;
  vertical-align: middle;
}

.giochi-grid {
  flex: 1;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
  padding: 2rem;
  background-color: #686D77;
}

.gioco-card {
  background-color: white;
  border-radius: 10px;
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.2s;
  height: fit-content;
}

.gioco-card:hover {
  transform: scale(1.05);
}

.gioco-card img {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.gioco-card h3 {
  padding: 1rem;
  margin: 0;
}

.piattaforma {
  color: #666;
  padding: 1rem;
  margin-bottom: 10px;
}

.gioco-card .prezzo {
  padding: 0 1rem 1rem;
  font-size: 1.2rem;
  font-weight: bold;
  color: #27ae60;
  text-align: right;
}

@media screen and (max-width: 768px) {
  .filtri-console {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .filtri-console button {
    margin: 0;
  }
}
</style>
