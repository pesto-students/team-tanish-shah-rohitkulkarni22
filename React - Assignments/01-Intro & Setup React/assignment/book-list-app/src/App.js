// src/App.js

import React from 'react';
import './App.css'; 
import './Components/Book.css';
import BookList from './Components/BookList';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>My Bookstore</h1>
      </header>
      <main>
        <BookList />
      </main>
    </div>
  );
}

export default App;

