<template>
  <div class="not-found">
    <h1>404 - Pagina non trovata</h1>
    <router-link to="/">Torna alla Home</router-link>
  </div>
</template>

<style scoped>
.not-found {
  text-align: center;
  padding: 100px 20px;
  color: white;
}

.not-found h1 {
  font-size: 3rem;
  margin-bottom: 20px;
}

.not-found p {
  font-size: 1.2rem;
  margin-bottom: 30px;
}

.not-found a {
  display: inline-block;
  padding: 12px 30px;
  background: #4a90e2;
  color: white;
  text-decoration: none;
  border-radius: 5px;
}

.not-found a:hover {
  background: #357abd;
}
</style>
