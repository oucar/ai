
import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
###### helper functions. Use them when needed #######

def get_title_from_index(index):
    return df[df.index == index]["title"].values[0]

def get_index_from_title(title):
    return df[df.title == title]["index"].values[0]
    
##################################################

# Step 1: Read CSV File
df = pd.read_csv("./movie_dataset.csv")
# print df.columns
# Step 2: Select Features

features = ['keywords', 'genres', 'director', 'vote_average', ]
# Step 3: Create a column in DF which combines all selected features
for feature in features:
    df[feature] = df[feature].fillna('')

def combine_features(row):
    try:
        return row['keywords']+" "+row["genres"]+" "+row["director"]
    except:
        print("Error:", row)

df["combined_features"] = df.apply(combine_features, axis=1)

# print "Combined Features:", df["combined_features"].head()

# Step 4: Create count matrix from this new combined column
cv = CountVectorizer()

count_matrix = cv.fit_transform(df["combined_features"])
cosine_sim = cosine_similarity(count_matrix)




def return_movies(user_input):
    # Step 5: Compute the Cosine Similarity based on the count_matrix
    # ! GETTING THE USER INPUT
    movie_user_likes = user_input

    # Step 6: Get index of this movie from its title
    movie_index = get_index_from_title(movie_user_likes)

    similar_movies = list(enumerate(cosine_sim[movie_index]))

    # Step 7: Get a list of similar movies in descending order of similarity score
    sorted_similar_movies = sorted(
        similar_movies, key=lambda x: x[1], reverse=True)

    # Step 8: Print titles of first 50 movies
    i = 0
    arr = []

    for element in sorted_similar_movies:

        #print(get_title_from_index(element[0]))
        arr.append(get_title_from_index(element[0]))

        i = i+1
        if i > 75:
            break

    # for item in arr:
        # print(item)
    return arr

# return_movies()

#if __name__ == "__main__":
#    return_movies()