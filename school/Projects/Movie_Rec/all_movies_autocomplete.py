import pandas as pd


def return_titles():
    column = ['title']
    df = pd.read_csv('./movie_dataset.csv', skipinitialspace=True, usecols=column)

    auto_complete = df.title.tolist()

    #for item in auto_complete:
        #print(item)

    return auto_complete

#return_titles()