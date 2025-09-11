Numpy is used due to it's usage of c/c++ processing, making its data structures much faster than native Python data structures.


```python
import numpy as np
import pandas as pd
```


```python
a = np.array((2, 3, 4, 6))
```


```python
b = np.array(
    [
        [1, 2, 3], [4, 5, 6]
    ]
)
```


```python
c = np.array([
    [
        [1, 2, 3], [4, 5, 6]
    ],
    [
        [7, 8, 9], [10, 11, 12]
    ]
])
```


```python
for x in c:
    print(x)
```

    [[1 2 3]
     [4 5 6]]
    [[ 7  8  9]
     [10 11 12]]



```python
for x in np.nditer(c):
    print(x)
```

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12



```python
for idx, x in np.ndenumerate(c):
    print(idx, x)
```

    (0, 0, 0) 1
    (0, 0, 1) 2
    (0, 0, 2) 3
    (0, 1, 0) 4
    (0, 1, 1) 5
    (0, 1, 2) 6
    (1, 0, 0) 7
    (1, 0, 1) 8
    (1, 0, 2) 9
    (1, 1, 0) 10
    (1, 1, 1) 11
    (1, 1, 2) 12



```python
c[0, 1]
```




    array([4, 5, 6])




```python
np.exp(b)
```




    array([[  2.71828183,   7.3890561 ,  20.08553692],
           [ 54.59815003, 148.4131591 , 403.42879349]])




```python
d = {
    'name': ['jay', 'jared'],
    'birth': [1997]
}
```


```python
d.values()
```




    dict_values([['jay', 'jared'], [1997]])




```python
d.items()
```




    dict_items([('name', ['jay', 'jared']), ('birth', [1997])])




```python
list(d.items())
```




    [('name', ['jay', 'jared']), ('birth', [1997])]




```python
for x in d:
    print(x)
```

    name
    birth



```python
for x, y in d.items():
    print(x, y)
```

    name ['jay', 'jared']
    birth [1997]



```python
sorted(d.items())  # Sorts by key
```




    [('birth', [1997]), ('name', ['jay', 'jared'])]




```python
e = {'pear': 1.99, 'banana': 0.59, 'blueberry': 3.49}
```


```python
# Sort by price but keep original contents of dictionary
sorted([(price, name) for name, price in e.items()])
```




    [(0.59, 'banana'), (1.99, 'pear'), (3.49, 'blueberry')]




```python
sorted(e.items(), key=lambda fruit: fruit[1])  # Alternative
```




    [('banana', 0.59), ('pear', 1.99), ('blueberry', 3.49)]




```python
e['pear']
```




    1.99




```python
e['apple']
```


    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    Cell In[22], line 1
    ----> 1 e['apple']


    KeyError: 'apple'



```python
e.get('apple')  # Gets object if it exists; gracefully handles KeyError
```


```python
import pandas as pd
```


```python
pd.DataFrame(b[0])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>




```python
a = pd.DataFrame(np.array(range(9)).reshape(3,3))
a
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1</th>
      <td>3</td>
      <td>4</td>
      <td>5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>6</td>
      <td>7</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>




```python
b = pd.DataFrame(np.array(range(10, 19)).reshape(3,3))
b
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10</td>
      <td>11</td>
      <td>12</td>
    </tr>
    <tr>
      <th>1</th>
      <td>13</td>
      <td>14</td>
      <td>15</td>
    </tr>
    <tr>
      <th>2</th>
      <td>16</td>
      <td>17</td>
      <td>18</td>
    </tr>
  </tbody>
</table>
</div>




```python
a.columns = ['a1', 'a2', 'a3']
b.columns = ['b1', 'b2', 'b3']

a, b
```




    (   a1  a2  a3
     0   0   1   2
     1   3   4   5
     2   6   7   8,
        b1  b2  b3
     0  10  11  12
     1  13  14  15
     2  16  17  18)




```python
a['a4'] = [1, 2, 4]
b['b4'] = [1, 2, 6]
```


```python
a, b
```




    (   a1  a2  a3  a4
     0   0   1   2   1
     1   3   4   5   2
     2   6   7   8   4,
        b1  b2  b3  b4
     0  10  11  12   1
     1  13  14  15   2
     2  16  17  18   6)




```python
a.merge(b, how='inner', left_on='a4', right_on='b4')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a1</th>
      <th>a2</th>
      <th>a3</th>
      <th>a4</th>
      <th>b1</th>
      <th>b2</th>
      <th>b3</th>
      <th>b4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>2</td>
      <td>13</td>
      <td>14</td>
      <td>15</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>




```python
a.melt(id_vars=['a4'], value_vars=['a1', 'a2', 'a3'], var_name='time', value_name='measurement')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a4</th>
      <th>time</th>
      <th>measurement</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>a1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>a1</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4</td>
      <td>a1</td>
      <td>6</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>a2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>a2</td>
      <td>4</td>
    </tr>
    <tr>
      <th>5</th>
      <td>4</td>
      <td>a2</td>
      <td>7</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1</td>
      <td>a3</td>
      <td>2</td>
    </tr>
    <tr>
      <th>7</th>
      <td>2</td>
      <td>a3</td>
      <td>5</td>
    </tr>
    <tr>
      <th>8</th>
      <td>4</td>
      <td>a3</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>




```python
c = pd.DataFrame({
    'c1': [1,2,3],
    'c2': [4,5,6]
})
c
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>c1</th>
      <th>c2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>6</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.Series({
    'c1': [1,2,3]
})
```




    c1    [1, 2, 3]
    dtype: object




```python
np.exp(c)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>c1</th>
      <th>c2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2.718282</td>
      <td>54.598150</td>
    </tr>
    <tr>
      <th>1</th>
      <td>7.389056</td>
      <td>148.413159</td>
    </tr>
    <tr>
      <th>2</th>
      <td>20.085537</td>
      <td>403.428793</td>
    </tr>
  </tbody>
</table>
</div>




```python
f = "abcsd"
f.startswith("ab"), f.endswith("s")
```




    (True, False)




```python
sample_output = ''
with open("sample.txt", 'r') as reader:
    sample_output = reader.readlines()
    sample_output = [
        text.strip('\n') for text in sample_output
    ]

print(sample_output[0].split('\n'))

```

    ['Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.']



```python

```
