## Dynamic ORM
- Build a parent class that our models can inherit from
- This class should set up the connection to the database, by inheriting from this class our model will have a connection to the db
- All of the behavior that is specific to communicating with the db, will be encapsulated in this parent class


## ActiveRecord Pattern
- One row in our database is represented by one object
- each column in the db represents one property of an object

## Object Relational Mapper (ORM)
- mapping database rows to ruby objects
- class relates to a table
- row of data one ruby instance
- database column equivalent to property/attribute of ruby instance


## CRUD REVIEW

What are the four ways we can interact with data?

CREATE
get info from cli application
save info to the database
after saving, create new instance of tweet

READ
read by id
read all elements out of the database
read the last record out of the database

UPDATE
on an instance
update the database with argument

DELETE/DESTROY
instance method
sql call to destroy




## Domain Modeling and SQL Review

Draw out what your schema (structure of your tables and columns) would be for the following domains. Consider what tables are needed, what columns belong on which tables, and where the foreign keys belong.

1. Books and Authors where each book has a single author. Books should have a title and authors should have a name
        | id |  title               
books
        1    | Prisoner of Azkaban   
        2    | Order of the Phoenix  
        3    | A Wrinkle in Time      
        4     Good Omens
        5      Graveyard Book

book_authors id | book_id  | author_id
              1   4         4
              2   4         5
              3   5         5

        | id  | name  | book_id
authors
          1   | JK Rowling | 1  |
          2   | Madeline L'Engle
        3      |  Terry Pratchet & Neil Gaiman | 4
        4      | Terry Pratchet
        5       | Neil Gaiman

Q: Write the SQL to find all books written by a certain author given the author's id.
SELECT * FROM books WHERE author_id = 1

2. Books and Authors where each book can have one or multiple authors. Books should have a title and authors should have a name

Q: Write the SQL to find all books written by a certain author given their name
SELECT * FROM books
JOIN book_authors ON book_authors.book_id = books.id
JOIN authors ON book_authors.author_id = authors.id

3. Twitter where Tweets can have Tags (i.e. '#fun', '#hottake', '#tbt'). A tweet can have multiple tags, many tweets can be tagged with the same tag. Tweets have a message and user_id; tags have a name.
      | id|  message | user_id
Tweets
belongs_to user
has_many tags

      |id | name | tweet1 | tweet2 | tweet3
Users
has_many tweets

      | id | text |tweet1 | tweet3 |
Tags
has_many tweets

            | id | tweet_id | tag_id |
Tweets_tags
belong_to tweet
belongs to a tag
              1 | 1     | 3 "tbt"
              1 | 1     | 4  "omgmyhair"

Q: Write the SQL to find all the tweets tagged '#tbt'
SELECT * from tweets
JOIN tweet_tags ON tweets.id = tweet_tags.tweet_id
JOIN tags ON tags.id = tweet_tags.tag_id
WHERE tags.text = "tbt"

4. After completing the questions above, is there a rule you can determine about which table the foreign key belongs on given two associated tables?

join table expresses a relationship
foreign key ids on a join table belongs to


Each row in a join table expresses one relationship (btwn author and book  or tweet and tag)
Foreign key belongs on the table with belongs to
