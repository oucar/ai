########## ML MODEL ##########

# What is abstract summarization: The technique of generating a summary of a text from its main ideas, not by copying verbatim most salient sentences from text.

### Docs
# https://ai.googleblog.com/2020/06/pegasus-state-of-art-model-for.html
# https://arxiv.org/abs/1912.08777
# https://huggingface.co/google/pegasus-xsum

### Use Cases
# Abstracting scientific papers, wikipedia posts, news, etc.

#### Installed dependencies: PyTorch, transformers, SentencePiece


#### Import and Load the Model
from transformers import PegasusForConditionalGeneration, PegasusTokenizer


#### Performing Abstractive Summarization
def abstract_sum(given_text):


    # Loading the models
    # Importing dependencies from transformers
    # Tokenizers can turn sentences into tokens, or unique identifiers,
    # Load the tokenizer 
    tokenizer = PegasusTokenizer.from_pretrained("google/pegasus-xsum")
    # Load the model 
    model = PegasusForConditionalGeneration.from_pretrained("google/pegasus-xsum")

    # Create tokens - number representation of the text (pt stands for pyTorch)
    tokens = tokenizer(given_text, truncation=True, padding="longest", return_tensors="pt")

    # Input tokens
    # print(tokens)

    # Summarize (unpacking the tokens -> dictionary)
    summary = model.generate(**tokens)

    # Output summary tokens
    # print(summary[0])

    # Decode summary
    result = tokenizer.decode(summary[0])

    # return the result
    print(result)
    return result



text = """
Python is an interpreted high-level general-purpose programming language. Its design philosophy emphasizes code readability with its use of significant indentation. Its language constructs as well as its object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects.[30]

Python is dynamically-typed and garbage-collected. It supports multiple programming paradigms, including structured (particularly, procedural), object-oriented and functional programming. It is often described as a "batteries included" language due to its comprehensive standard library.[31]

Guido van Rossum began working on Python in the late 1980s, as a successor to the ABC programming language, and first released it in 1991 as Python 0.9.0.[32] Python 2.0 was released in 2000 and introduced new features, such as list comprehensions and a garbage collection system using reference counting. Python 3.0 was released in 2008 and was a major revision of the language that is not completely backward-compatible. Python 2 was discontinued with version 2.7.18 in 2020.[33]

Python consistently ranks as one of the most popular programming languages.[34][35][36][37]"""


abstract_sum(text)