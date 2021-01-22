# Regular expressions
# source: https://regexone.com/

library(stringr)

# find pattern that matches all entries in chars
chars = c("abcdefg", "abcde", "abc")


# find pattern that matches all entries in chars
# \\d : any digit
chars = c("abc123xyz", ' define "123" ', "var g = 123;")


# match first three entries, but not last
chars = c("cat.", "896.", "?+-.", "abc1")


# match only first 3 entries
# [abc]: match a, b, c and nothing else
chars = c("can", "man", "fan", "dan", "ran", "pan")

# match first 2 entries
chars = c("hog", "dog", "bog")

# match first 3 entries
# [A-Z]: any letter from A - Z (case sensitive)
# can use ranges with numbers as well
chars = c("Ana", "Bob", "Cpc", "aax", "bby", "ccz")

# match first 2 entries
# {n}: repeat (at least) n times
chars = c("wazzzzzup", "wazzzup", "wazup")


# match first 3 entries
# * 0 or more appearances
# + one or more appearances
chars = c("aaaabcc", "aabbbbc", "aacc", "a")


# match first 3 entries
char = c("1 file found?", "2 files found?", "24 files found?", "No files found.")


# match first 3 entries
# \s: any whitespace
char = c("1.  abc", "2.   abc", "3.    abc", "4.abc")

# match first 
# ^...: starts with
# ...$: ends with
char = c("Mission: successful", "Mission: unsuccessful", "Next Mission: we shall see")
str_detect(char, "M") # wouldn't work

