from flask import Flask, render_template, request
import recommendation
import all_movies_autocomplete

app = Flask(__name__)


@app.route("/", methods=["POST", "GET"])
def index():
    titles = all_movies_autocomplete.return_titles()

    if request.method == 'POST':
        movies = request.form['title_selected']
        arr = recommendation.return_movies(movies)
        return render_template("index.html", arr = arr, titles = titles, movies = movies)

    else:
        user = request.args.get('nm')
        return render_template("index.html", titles = titles)




if __name__ == "__main__":
    # recommendation.return_movies()
    app.run(debug=True)