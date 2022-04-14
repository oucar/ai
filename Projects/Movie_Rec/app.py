from flask import Flask, render_template
import recommendation

app = Flask(__name__)


@app.route("/")
def index():
    arr = recommendation.return_movies()
    # return_arr = recommendation.return_movies()
    return render_template("index.html", arr = arr)

if __name__ == "__main__":
    # recommendation.return_movies()
    app.run(debug=True)