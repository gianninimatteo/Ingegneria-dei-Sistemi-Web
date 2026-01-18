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
    },
    giochiRaggruppatiPerMese(): { [key: string]: Gioco[] } {
      const gruppi: { [key: string]: Gioco[] } = {}
      
      this.giochiFiltrati.forEach(gioco => {
        const data = new Date(gioco.data_rilascio)
        const mese = data.toLocaleDateString('it-IT', { month: 'long', year: 'numeric' })
        const meseCapitalizzato = mese.charAt(0).toUpperCase() + mese.slice(1)
        
        if (!gruppi[meseCapitalizzato]) {
          gruppi[meseCapitalizzato] = []
        }
        gruppi[meseCapitalizzato].push(gioco)
      })
      
      return gruppi
    }
  },
  methods: {
    async caricaGiochi() {
      try {
        const response = await axios.get("http://localhost:3000/api/prossimeUscite", {
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
    },
    formatData(data: string): string {
      const d = new Date(data)
      return d.toLocaleDateString('it-IT', { day: 'numeric', month: 'long', year: 'numeric' })
    }
  }
})
</script>

<template>
  <div class="prossime-uscite-page">
    <div class="filtri-console">
      <button @click="selezionaConsole('Tutte')" :class="{ active: consoleSelezionata === 'Tutte' }"><img src="/icons/tutti.png" alt="tutti">Tutti</button>
      <button @click="selezionaConsole('PC')" :class="{ active: consoleSelezionata === 'PC' }"><img src="/icons/pc.png" alt="PC"> PC</button>
      <button @click="selezionaConsole('PlayStation')" :class="{ active: consoleSelezionata === 'PlayStation' }"><img src="/icons/playstation.png" alt="playstation"> PlayStation</button>
      <button @click="selezionaConsole('Xbox')" :class="{ active: consoleSelezionata === 'Xbox' }"><img src="/icons/xbox.png" alt="xbox"> Xbox</button>
      <button @click="selezionaConsole('Nintendo')" :class="{ active: consoleSelezionata === 'Nintendo' }"><img src="/icons/nintendo.png" alt="nintendo"> Nintendo</button>
    </div>

    <main class="giochi-container">
      <div v-for="(giochi, mese) in giochiRaggruppatiPerMese" :key="mese" class="gruppo-mese">
        <h2 class="titolo-mese">{{ mese }}</h2>
        
        <div class="giochi-grid">
          <div 
            v-for="gioco in giochi" 
            :key="gioco.id" 
            class="gioco-card"
            @click="vaiADettaglio(gioco.id)"
          >
            <img :src="`http://localhost:3000/img/${gioco.immagine_url}`" :alt="gioco.titolo">
            <div class="gioco-info">
              <h3>{{ gioco.titolo }}</h3>
              <p class="piattaforma">{{ gioco.piattaforma }}</p>
              <p class="data">{{ formatData(gioco.data_rilascio) }}</p>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
.prossime-uscite-page {
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

.giochi-container {
  flex: 1;
  padding: 2rem;
  background-color: #686D77;
}

.gruppo-mese {
  margin-bottom: 3rem;
}

.titolo-mese {
  color: white;
  font-size: 2rem;
  margin-bottom: 1.5rem;
  padding-left: 1rem;
  border-left: 5px solid #3498db;
}

.giochi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
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

.gioco-info {
  padding: 1rem;
}

.gioco-card h3 {
  margin: 0 0 0.5rem 0;
}

.piattaforma {
  color: #666;
  margin-top: 2rem;
  margin-bottom: 10px;
}

.gioco-card .data {
  color: #7f8c8d;
  font-size: 0.9rem;
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
