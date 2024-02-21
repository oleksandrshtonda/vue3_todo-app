<script>
  export default {
    props: {
      text: String,
      active: Boolean
    },
    emits: ['hide'],
    methods: {
      hide() {
        this.$emit('hide');
      }
    }
  }
</script>

<template>
  <article
    class="message"
    :class="{ 'message--hidden' : !active }"
  >
    <div class="message-header">
      <slot name="header"></slot>
      <button class="delete" @click="hide"></button>
    </div>

    <div class="message-body">
      <slot>Error message</slot>
    </div>
  </article>
</template>
