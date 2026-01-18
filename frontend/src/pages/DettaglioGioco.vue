<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"
import type { Gioco, Recensione, User } from "../types"

export default defineComponent({
  data() {
    return {
      gioco: null as Gioco | null,
      recensioni: [] as Recensione[],
      nuovaRecensione: "",
      user: null as User | null,
      giocoAcquistato: false,
    }
  },
  async mounted() {
    await this.caricaGioco()
    await this.caricaRecensioni()
    await this.caricaUtente()
    await this.verificaAcquisto()
  },
  methods: {
    async caricaGioco() {
      try {
        const id = this.$route.params.id
        const response = await axios.get(`http://localhost:3000/api/giochi/${id}`, {
          withCredentials: true
        })
        this.gioco = response.data[0]
      } catch (e: any) {
        console.error(e)
        alert("Errore nel caricamento del gioco")
      }
    },
    async caricaRecensioni() {
      try {
        const id = this.$route.params.id
        const response = await axios.get(`http://localhost:3000/api/recensioni/${id}`, {
          withCredentials: true
        })
        this.recensioni = response.data
      } catch (e: any) {
        console.error(e)
      }
    },
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
    async verificaAcquisto() {
      try {
        const id = this.$route.params.id
        const response = await axios.get(`http://localhost:3000/api/acquisti/verifica/${id}`, {
          withCredentials: true
        })
        this.giocoAcquistato = response.data.acquistato
      } catch (e) {
        console.error(e)
      }
    },
    async aggiungiAlCarrello() {
      try {
        await axios.post("http://localhost:3000/api/carrello", 
          { gioco_id: this.gioco?.id },
          { withCredentials: true }
        )
        alert("Gioco aggiunto al carrello!")
      } catch (e: any) {
        alert(e.response?.data || "Errore")
      }
    },
    async pubblicaRecensione() {
      if (!this.nuovaRecensione.trim()) {
        alert("Scrivi una recensione prima di pubblicare")
        return
      }
      try {
        await axios.post("http://localhost:3000/api/recensioni",
          { gioco_id: this.gioco?.id, contenuto: this.nuovaRecensione },
          { withCredentials: true }
        )
        this.nuovaRecensione = ""
        await this.caricaRecensioni()
      } catch (e: any) {
        alert(e.response?.data || "Errore")
      }
    },
    async eliminaRecensione(id: number) {
      if (!confirm("Vuoi davvero eliminare questa recensione?")) return
      try {
        await axios.delete(`http://localhost:3000/api/recensioni/${id}`, {
          withCredentials: true
        })
        await this.caricaRecensioni()
      } catch (e: any) {
        alert(e.response?.data || "Errore")
      }
    },
    possoEliminare(recensione: Recensione): boolean {
      if (!this.user) return false
      return this.user.id === recensione.utente_id || this.user.role === 'admin'
    },
    formatData(data: string): string {
      const d = new Date(data)
      return d.toLocaleDateString('it-IT', { day: 'numeric', month: 'long', year: 'numeric' })
    }
  }
})
</script>

<template>
  <div class="dettaglio-page" v-if="gioco">
    <main class="dettaglio-container">
      <div class="gioco-dettaglio">
        <div class="gioco-immagine">
          <img :src="`http://localhost:3000/img/${gioco.immagine_url}`" :alt="gioco.titolo">
        </div>
        
        <div class="gioco-info">
          <h1>{{ gioco.titolo }}</h1>
          <p class="prezzo">{{ gioco.prezzo }} €</p>
          <button @click="aggiungiAlCarrello" class="btn-carrello" :disabled="giocoAcquistato || gioco.prossima_uscita === 1"><img src="/icons/carrello.png" alt="carrello"> Aggiungi al carrello</button>
          
          <div class="dettagli">
            <h2>Descrizione</h2>
            <p>{{ gioco.descrizione }}</p>
            
            <h3>Sviluppatore</h3>
            <p>{{ gioco.sviluppatore }}</p>
            
            <h3>Data di Rilascio</h3>
            <p>{{ formatData(gioco.data_rilascio) }}</p>
            
            <h3>Genere</h3>
            <p>{{ gioco.genere }}</p>
            
            <h3>Installazione</h3>
            <p>{{ gioco.installazione }}</p>
          </div>
        </div>
      </div>

      <div class="recensioni-section">
        <h2>Recensioni</h2>
        
        <div class="nuova-recensione">
          <textarea 
            v-model="nuovaRecensione" 
            placeholder="Scrivi quello che vuoi..."
            rows="5"
          ></textarea>
          <button @click="pubblicaRecensione">Posta</button>
        </div>

        <div class="recensioni-lista">
          <h3>Le ultime recensioni</h3>
          <div 
            v-for="recensione in recensioni" 
            :key="recensione.id" 
            class="recensione-item"
          >
            <div class="recensione-header">
              <strong>{{ recensione.username }}</strong>
            </div>
            <p>{{ recensione.contenuto }}</p>
            <button 
              v-if="possoEliminare(recensione)" 
              @click="eliminaRecensione(recensione.id)"
              class="btn-elimina"
            >
              <img src="/icons/cestino.png" alt="cestino">
            </button>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
.dettaglio-page {
  flex: 1;
  background-color: #686D77;
}

.dettaglio-container {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.gioco-dettaglio {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 2rem;
  background-color: white;
  padding: 2rem;
  border-radius: 10px;
  margin-bottom: 2rem;
}

.gioco-immagine img {
  width: 100%;
  border-radius: 10px;
}

.gioco-info h1 {
  margin: 0 0 1rem 0;
}

.prezzo {
  font-size: 2rem;
  font-weight: bold;
  color: #27ae60;
  margin: 1rem 0;
}

.btn-carrello {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.1rem;
  border-radius: 5px;
  cursor: pointer;
  margin-bottom: 2rem;
}
.btn-carrello img {
  width: 30px;
  vertical-align: middle;
  margin-right: 10px;
}

.btn-carrello:hover {
  background-color: #c0392b;
}

.btn-carrello:disabled {
  background-color: #95a5a6;
  cursor: not-allowed;
  opacity: 0.6;
}

.btn-carrello:disabled:hover {
  background-color: #95a5a6;
}

.dettagli h2, .dettagli h3 {
  margin-top: 1.5rem;
  margin-bottom: 0.5rem;
}

.dettagli p {
  margin: 0.5rem 0;
  line-height: 1.6;
}

.recensioni-section {
  background-color: white;
  padding: 2rem;
  border-radius: 10px;
}

.recensioni-section h2 {
  margin: 0 0 2rem 0;
}

.nuova-recensione {
  margin-bottom: 2rem;
}

.nuova-recensione textarea {
  width: 100%;
  padding: 1rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-family: Arial, sans-serif;
  resize: vertical;
}

.nuova-recensione button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 0.75rem 2rem;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 0.5rem;
}

.nuova-recensione button:hover {
  background-color: #2980b9;
}

.recensioni-lista h3 {
  margin: 2rem 0 1rem 0;
}

.recensione-item {
  background-color: #ecf0f1;
  padding: 1.5rem;
  border-radius: 5px;
  margin-bottom: 1rem;
  position: relative;
}

.recensione-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 0.5rem;
  font-size: 1.1rem;
  color: #3498db;
}

.recensione-item p {
  margin: 0.5rem 0 0 0;
}

.btn-elimina {
  position: absolute;
  top: 1.5rem;
  right: 1rem;
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 0.5rem;
  border-radius: 5px;
  cursor: pointer;
}

.btn-elimina:hover {
  background-color: #c0392b;
}

@media screen and (max-width: 768px) {
  .gioco-dettaglio {
    grid-template-columns: 1fr;
  }
}
</style>
