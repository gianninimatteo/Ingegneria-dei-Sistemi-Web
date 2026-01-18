<script lang="ts">
import axios from "axios"
import { defineComponent } from "vue"
import type { CarrelloItem } from "../types"

export default defineComponent({
  data() {
    return {
      carrello: [] as CarrelloItem[],
      numeroCarta: "",
      totale: 0,
    }
  },
  async mounted() {
    await this.caricaCarrello()
  },
  methods: {
    async caricaCarrello() {
      try {
        const response = await axios.get("http://localhost:3000/api/carrello", {
          withCredentials: true
        })
        this.carrello = response.data
        this.totale = this.carrello.reduce((sum, item) => sum + item.prezzo, 0)
      } catch (e: any) {
        console.error(e)
        alert("Errore nel caricamento del carrello")
      }
    },
    async procediPagamento() {
      if (!this.numeroCarta.trim()) {
        alert("Inserisci un numero di carta")
        return
      }
      
      if (this.carrello.length === 0) {
        alert("Il carrello è vuoto")
        return
      }

      try {
        await axios.post("http://localhost:3000/api/acquisti", {}, {
          withCredentials: true
        })
        alert("Pagamento completato! I tuoi giochi sono ora nella libreria.")
        this.$router.push("/libreria")
      } catch (e: any) {
        alert(e.response?.data || "Errore nel pagamento")
      }
    }
  }
})
</script>

<template>
  <div class="checkout-page">
    <main class="checkout-container">
      <h1>Pagina Pagamento</h1>
      
      <div class="pagamento-box">
        <h2>Pagamento</h2>
        
        <div class="form-group">
          <label>Numero Carta</label>
          <input 
            type="text" 
            v-model="numeroCarta" 
            maxlength="16"
          >
        </div>

        <div class="totale-box">
          <span>Totale</span>
          <span class="prezzo-totale">{{ totale.toFixed(2) }} €</span>
        </div>

        <button @click="procediPagamento" class="btn-paga">Paga</button>
      </div>
    </main>
  </div>
</template>

<style scoped>
.checkout-page {
  flex: 1;
  background-color: #686D77;
  display: flex;
  justify-content: center;
  align-items: center;
}

.checkout-container {
  padding: 2rem;
  max-width: 600px;
  width: 100%;
}

.checkout-container h1 {
  color: white;
  margin-bottom: 1rem;
  text-align: center;
}

.pagamento-box {
  background-color: white;
  padding: 2rem;
  border-radius: 10px;
}

.pagamento-box h2 {
  margin: 0 0 2rem 0;
  text-align: center;
}

.form-group {
  margin-bottom: 2rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

.form-group input {
  width: 100%;
  padding: 1rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 1rem;
}

.totale-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem;
  background-color: #ecf0f1;
  border-radius: 5px;
  margin-bottom: 2rem;
  font-size: 1.5rem;
  font-weight: bold;
}

.prezzo-totale {
  color: #27ae60;
}

.btn-paga {
  width: 100%;
  background-color: #27ae60;
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.2rem;
  border-radius: 5px;
  cursor: pointer;
}

.btn-paga:hover {
  background-color: #229954;
}
</style>
