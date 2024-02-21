<script>
  import StatusFilter from './components/StatusFilter.vue';
  import TodoItem from "@/components/TodoItem.vue";
  import {createTodo, deleteTodo, getTodos, updateTodo} from "@/api/todos.api.js";
  import Message from "@/components/Message.vue";

  export default {
    components: {
      TodoItem,
      StatusFilter,
      Message,
    },
    data() {
      return {
        todos: [],
        title: '',
        status: 'all',
        errorMessage: '',
      };
    },
    computed: {
      activeTodos() {
        return this.todos.filter(todo => !todo.completed);
      },
      completedTodos() {
        return this.todos.filter(todo => todo.completed);
      },
      visibleTodos() {
        switch (this.status) {
          case 'active':
            return this.activeTodos;

          case 'completed':
            return this.completedTodos;

          default:
            return this.todos;
        }
      }
    },
    mounted() {
      getTodos()
        .then(({ data }) => this.todos = data)
        .catch(() => {
          this.errorMessage = 'Unable to load todos'
        })
    },
    methods: {
      handleSubmit() {
        if (this.title.trim().length < 3) {
          return;
        }

      createTodo(this.title.trim())
        .then(({data}) => {
          this.todos = [...this.todos, data];
          this.title = '';
        })
        .catch(() => {
          this.errorMessage = 'Unable to create the todo'
        });
      },
      updateTodo({ id, title, completed }) {
        updateTodo({ id, title, completed })
          .then(({ data }) => {
            this.todos = this.todos.map(todo => todo.id !== id ? todo : data);
          })
          .catch(() => {
            this.errorMessage = 'Unable to update the todo'
          });
      },
      deleteTodo(todoId) {
        deleteTodo(todoId)
          .then(() => {
            this.todos = this.todos.filter(todo => todo.id !== todoId);
          })
          .catch(() => {
            this.errorMessage = 'Unable to delete the todo'
          });
      }
    },
  }
</script>

<template>
  <div class="todoapp">
    <h1 class="todoapp__title">ToDo App</h1>

    <div class="todoapp__content">
      <header class="todoapp__header">
        <button
            class="todoapp__toggle-all"
            :class="{ active: activeTodos.length === 0 }"
        ></button>

        <form @submit.prevent="handleSubmit">
          <input
            type="text"
            class="todoapp__new-todo"
            placeholder="What needs to be done?"
            v-model="title"
          >
        </form>
      </header>

      <TransitionGroup
        name="list"
        tag="section"
        class="todoapp__main"
      >
        <TodoItem
          v-for="(todo) of visibleTodos"
          v-bind:key="todo.id"
          :todo="todo"
          @update="updateTodo"
          @delete="deleteTodo(todo.id)"
        />
      </TransitionGroup>

      <footer class="todoapp__footer">
        <span class="todo-count">
          {{ activeTodos.length }} items left
        </span>

        <StatusFilter
          v-model="status"
        />

        <button class="todoapp__clear-completed" v-if="activeTodos.length > 0">
          Clear completed
        </button>
      </footer>
    </div>

    <Message
      class="is-danger"
      :active="errorMessage !== ''"
      @hide="errorMessage = ''"
    >
      <template #default>
        <p>{{ errorMessage }}</p>
      </template>

      <template #header>
        <p>Server Error</p>
      </template>
    </Message>
  </div>
</template>
