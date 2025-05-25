### প্রশ্ন-১: What is PostgreSQL?(PostgreSQL কী?)
PostgreSQL: PostgreSQL হলো একটি রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি সম্পূর্ণ ফ্রি এবং ওপেন-সোর্স। PostgreSQL ডেটা টেবিলে সংরক্ষণ করে যেখানে foreign key, joins এবং অন্যান্য রিলেশনাল অপারেশনের মাধ্যমে টেবিলগুলোর মধ্যে সম্পর্ক তৈরি করা যায়। এটি অত্যন্ত শক্তিশালী এবং নির্ভরযোগ্য RDBMS।

### প্রশ্ন-৩: Explain the Primary Key and Foreign Key concepts in PostgreSQL.
Primary Key: Primary Key হল একটি কলাম বা একাধিক কলামের সমষ্টি, যা একটি টেবিলের প্রতিটি রো (সারি) কে অন্য রো থেকে আলাদা বা ইউনিকভাবে শনাক্ত করে। প্রতিটি টেবিলে শুধুমাত্র একটি Primary Key থাকবে এবং এটি NULL হতে পারবে না।
উদাহরণ:
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);
এখানে ranger_id হচ্ছে Primary Key, যার মাধ্যমে প্রতিটি রেঞ্জারকে ইউনিকভাবে শনাক্ত করা যাবে।

Foreign Key: Foreign Key হল একটি কলাম বা একাধিক কলামের সমষ্টি, যা অন্য একটি টেবিলের Primary Key-কে রেফারেন্স করে। এটি দুইটি টেবিলের মধ্যে সম্পর্ক স্থাপন করে। ডিজাইনের উপর ভিত্তি করে Foreign Key NULL হতে পারে এবং এখানে ডুপ্লিকেট ভ্যালু থাকতে পারে,  এটি Primary Key এর মত ইউনিক হয় না।
উদাহরণ:
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY NOT NULL,
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);
এখানে ranger_id হল sightings টেবিলের foreign key যা rangers টেবিলে ranger_id এর রেফারেন্স।

### প্রশ্ন-৪: What is the difference between the VARCHAR and CHAR data types?
CHAR এবং VARCHAR এর পার্থক্য নিচে দেওয়া হলো:
| CHAR (ফিক্সড দৈর্ঘ্য)                                                 | VARCHAR (ভ্যারিয়েবল দৈর্ঘ্য)                                  |
|-------------------------------------------------------------------|------------------------------------------------------------------|
| Fixed-length character ডাটা টাইপ                                   | Variable-length character ডাটা টাইপ                              |
| এটি নির্দিষ্ট দৈর্ঘ্যের ডেটা সংরক্ষণ করে                                   | এটি কেবল প্রয়োজনীয় ডেটা সংরক্ষণ করে                          |
| ইনপুট ছোট হলে, অতিরিক্ত অংশ space দিয়ে পূরণ করে                   | ইনপুট ছোট হলে, কেবল প্রয়োজনীয় অংশই ব্যবহার করে              |
| fixed length ডেটার জন্য দ্রুত কাজ করে, যেমন: gender, status codes. | fixed length ডেটার জন্য তুলনামূলক ধীরে কাজ করে, তবে flexible and space-efficient ডেটার জন্য ভালো এটি, যেমন: names or emails.|

### প্রশ্ন-৫: Explain the purpose of the WHERE clause in a SELECT statement.
একটি SELECT স্টেটমেন্টে WHERE clause নির্দিষ্ট শর্তের ভিত্তিতে ডেটা ফিল্টার করতে ব্যবহৃত হয়। এটি শুধুমাত্র সেই সারিগুলো (rows) রিটার্ন করে, যেগুলো শর্ত পূরণ করে।
উদাহরণ:
SELECT * 
FROM rangers
WHERE region = 'Mountain Range';
এই কুয়েরিটি শুধুমাত্র সেই rangers রিটার্ন করবে যাদের region হলো "Mountain Range"। 

### প্রশ্ন-৬: What are the LIMIT and OFFSET clauses used for?
LIMIT: একটি table থেকে সর্বোচ্চ কয়টি record/row রিটার্ন করবে তা নির্ধারণ করতে LIMIT clause ব্যবহার করা হয় ।
OFFSET: একটি table থেকে প্রথম কয়টি রেকর্ড skip/বাদ দিয়ে তারপর ফলাফল দেখাবে তা নির্ধারণ করতে OFFSET clause ব্যবহার করা হয় ।
উদাহরণ:
SELECT * 
FROM rangers
ORDER BY ranger_id
LIMIT 5 OFFSET 10;
এখানে প্রথম ১০টি রেকর্ড বাদ দিবে, এরপর পরবর্তী ৫টি রেকর্ড রিটার্ন করবে।
