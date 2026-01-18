<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"
import type { CarrelloItem } from "../types"

export default defineComponent({
  data() {
    return {
      carrello: [] as CarrelloItem[],
    }
  },
  async mounted() {
    await this.caricaCarrello()
  },
  computed: {
    totale(): number {
      return this.carrello.reduce((sum, item) => sum + item.prezzo, 0)
    }
  },
  methods: {
    async caricaCarrello() {
      try {
        const response = await axios.get("http://localhost:3000/api/carrello", {
          withCredentials: true
        })
        this.carrello = response.data
      } catch (e: any) {
        console.error(e)
        alert("Errore nel caricamento del carrello")
      }
    },
    async rimuoviDalCarrello(gioco_id: number) {
      try {
        await axios.delete(`http://localhost:3000/api/carrello/${gioco_id}`, {
          withCredentials: true
        })
        await this.caricaCarrello()
      } catch (e: any) {
        alert(e.response?.data || "Errore")
      }
    },
    procediAlCheckout() {
      if (this.carrello.length === 0) {
        alert("Il carrello è vuoto")
        return
      }
      this.$router.push("/checkout")
    }
  }
})
</script>

<template>
  <div class="carrello-page">
    <main class="carrello-container">
      <h1>Pagina Carrello</h1>
      
      <div class="carrello-content">
        <div class="carrello-lista">
          <h2>Carrello</h2>
          
          <div v-if="carrello.length === 0" class="carrello-vuoto">
            <p>Il tuo carrello è vuoto</p>
          </div>
          
          <div v-else class="giochi-carrello">
            <div 
              v-for="item in carrello" 
              :key="item.id" 
              class="carrello-item"
            >
              <img :src="`http://localhost:3000/img/${item.immagine_url}`" :alt="item.titolo">
              <div class="item-info">
                <h3>{{ item.titolo }}</h3>
                <p class="prezzo">{{ item.prezzo.toFixed(2) }} €</p>
              </div>
              <button @click="rimuoviDalCarrello(item.gioco_id)" class="btn-rimuovi">🗑️</button>
            </div>
          </div>
        </div>

        <div class="riepilogo">
          <h2>Riepilogo</h2>
          <div class="riepilogo-content">
            <div class="totale-row">
              <span>Totale</span>
              <span class="totale-prezzo">{{ totale.toFixed(2) }} €</span>
            </div>
            <button @click="procediAlCheckout" class="btn-avanti">Avanti</button>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
.carrello-page {
  flex: 1;
  background-color: #686D77;
}

.carrello-container {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.carrello-container h1 {
  color: white;
  margin-bottom: 2rem;
}

.carrello-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
}

.carrello-lista, .riepilogo {
  background-color: white;
  padding: 2rem;
  border-radius: 10px;
}

.carrello-lista h2, .riepilogo h2 {
  margin: 0 0 1.5rem 0;
}

.carrello-vuoto {
  text-align: center;
  padding: 3rem;
  color: black;
}

.giochi-carrello {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.carrello-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  border: 1px solid #ecf0f1;
  border-radius: 5px;
  position: relative;
}

.carrello-item img {
  width: 120px;
  height: 80px;
  object-fit: cover;
  border-radius: 5px;
}

.item-info {
  flex: 1;
}

.item-info h3 {
  margin: 0 0 0.5rem 0;
}

.item-info .prezzo {
  font-size: 1.2rem;
  font-weight: bold;
  color: #27ae60;
  margin: 0;
}

.btn-rimuovi {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1.2rem;
}

.btn-rimuovi:hover {
  background-color: #c0392b;
}

.riepilogo-content {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.totale-row {
  display: flex;
  justify-content: space-between;
  font-size: 1.5rem;
  font-weight: bold;
  padding: 1rem 0;
  border-top: 2px solid #ecf0f1;
  border-bottom: 2px solid #ecf0f1;
}

.totale-prezzo {
  color: #27ae60;
}

.btn-avanti {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.1rem;
  border-radius: 5px;
  cursor: pointer;
}

.btn-avanti:hover {
  background-color: #2980b9;
}

@media screen and (max-width: 768px) {
  .carrello-content {
    grid-template-columns: 1fr;
  }
}
</style>
