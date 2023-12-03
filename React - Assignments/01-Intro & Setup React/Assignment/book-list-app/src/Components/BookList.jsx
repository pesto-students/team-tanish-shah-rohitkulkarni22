// src/BookList.js

import React, { Component } from 'react';
import Book from './Book';

const books = [
  { title: 'Book 1', author: 'Author 1', year: 2020 },
  { title: 'Book 2', author: 'Author 2', year: 2018 },
  { title: 'Book 3', author: 'Author 3', year: 2022 },
  // Add more books if you'd like
];

// Converting the Booklist Functional Component into a class-based component.
// using the render() method

class BookList extends Component {
    render() {
      return (
        <div>
          <h2>List of Books</h2>
          <ul>
            {books.map((book, index) => (
              <li key={index}>
                <Book
                  title={book.title}
                  author={book.author}
                  year={book.year}
                />
              </li>
            ))}
          </ul>
        </div>
      );
    }
  }
  
  export default BookList;