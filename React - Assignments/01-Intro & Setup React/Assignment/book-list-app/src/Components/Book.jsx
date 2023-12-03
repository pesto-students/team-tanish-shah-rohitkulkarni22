// src/Book.jsx

import React from 'react';

function Book(props) {
  const { title, author, year } = props;

  return (
    <div>
      <h3>{title}</h3>
      <p>Author: {author}</p>
      <p>Year: {year}</p>
    </div>
  );
}

export default Book;