<script setup>
</script>

<template>
  <div class="todoapp">
    <h1 class="todoapp__title">todos</h1>

    <div class="todoapp__content">
      <header class="todoapp__header">
        <button class="todoapp__toggle-all active"></button>

        <form>
          <input
            type="text"
            class="todoapp__new-todo"
            placeholder="What needs to be done?"
          >
        </form>
      </header>

      <section class="todoapp__main">
        <div class="todo completed">
          <label class="todo__status-label">
            <input
              type="checkbox"
              class="todo__status"
              checked
            >
          </label>

          <span class="todo__title">Completed Todo</span>

          <button class="todo__remove">x</button>

          <div class="modal overlay">
            <div class="modal-background has-background-white-ter"></div>
            <div class="loader"></div>
          </div>
        </div>
      </section>
    </div>

    <article class="message is-danger message--hidden">
      <div class="message-header">
        <p>Error</p>
        <button class="delete"></button>
      </div>

      <div class="message-body">
        Unable to add a Todo
      </div>
    </article>
  </div>
</template>
