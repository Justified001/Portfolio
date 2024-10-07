```python
import os, shutil


```


```python
path = (r'C:/Users/feyis/OneDrive/Documents/Portfolio Project/')

os.listdir(path)
```




    ['.vs',
     'covid death.csv',
     'covid death.xlsx',
     'covid vaccination.csv',
     'covid vaccination.xlsx',
     'csv files',
     'excel files',
     'Nashville Housing Data for Data Cleaning (reuploaded).xlsx',
     'Nashville Housing Project  Cleaned Data With SQL.xlsx',
     'Portfoliio Project.twb',
     'Portfolio Project_Covid Data SQL Script.ssmssln',
     'Solution1.ssmssln',
     'Tablaeu Table 1.xlsx',
     'Tablaeu Table 3.xlsx',
     'Tablaeu Table 4.xlsx',
     'Tablaeu.txt',
     'Tableau files',
     'Tableau Table 2.xlsx',
     'Tableau Visa=ualisation.twb']




```python
folder_names = ['excel files', 'SQL files','csv script', 'text files']

for loop in range(0,2):
    if not os.path.exists(path + folder_names[loop]):
        os.makedirs(path + folder_names[loop])
```


```python
folders = (path + folder_names[loop])
```


```python
import os, shutil

path = (r'C:/Users/feyis/OneDrive/Documents/Portfolio Project/')


folder_names = ['excel files', 'SQL files','csv script', 'text files', 'Tableau files']

for loop in range(0,5):
    if not os.path.exists(path + folder_names[loop]):
        os.makedirs(path + folder_names[loop])
```


```python
file_name = os.listdir(path)
```


```python
for file in file_name:
    if '.csv' in file and not os.path.exists(path + 'csv files/' + file):
        shutil.move(path + file, path + 'csv files/' + file)
```


```python
for file in file_name:
    if '.xlsx' in file and not os.path.exists(path + 'excel files/' + file):
        shutil.move(path + file, path + 'excel files/' + file)
```


```python
for file in file_name:
    if '.twb' in file and not os.path.exists(path + 'Tableau files/' + file):
        shutil.move(path + file, path + 'Tableau files/' + file)
```


    ---------------------------------------------------------------------------

    FileNotFoundError                         Traceback (most recent call last)

    File ~\anaconda3\Lib\shutil.py:847, in move(src, dst, copy_function)
        846 try:
    --> 847     os.rename(src, real_dst)
        848 except OSError:
    

    FileNotFoundError: [WinError 2] The system cannot find the file specified: 'C:/Users/feyis/OneDrive/Documents/Portfolio Project/Portfoliio Project.twb' -> 'C:/Users/feyis/OneDrive/Documents/Portfolio Project/Tableau files/Portfoliio Project.twb'

    
    During handling of the above exception, another exception occurred:
    

    FileNotFoundError                         Traceback (most recent call last)

    Cell In[98], line 3
          1 for file in file_name:
          2     if '.twb' in file and not os.path.exists(path + 'Tableau files/' + file):
    ----> 3         shutil.move(path + file, path + 'Tableau files/' + file)
    

    File ~\anaconda3\Lib\shutil.py:867, in move(src, dst, copy_function)
        865         rmtree(src)
        866     else:
    --> 867         copy_function(src, real_dst)
        868         os.unlink(src)
        869 return real_dst
    

    File ~\anaconda3\Lib\shutil.py:460, in copy2(src, dst, follow_symlinks)
        458     flags |= _winapi.COPY_FILE_COPY_SYMLINK
        459 try:
    --> 460     _winapi.CopyFile2(src_, dst_, flags)
        461     return dst
        462 except OSError as exc:
    

    FileNotFoundError: [WinError 2] The system cannot find the file specified



```python
for file in file_name:
    if '.ssmssln' in file and not os.path.exists(path + 'Tableau files/' + file):
        shutil.move(path + file, path + 'Tableau files/' + file)
```


```python
import os, shutil

path = (r'C:/Users/feyis/OneDrive/Documents/Portfolio Project/')


folder_names = ['excel files', 'SQL files','csv script', 'text files', 'Tableau files']

for loop in range(0,5):
    if not os.path.exists(path + folder_names[loop]):
        os.makedirs(path + folder_names[loop])

folders = (path + folder_names[loop])

file_name = os.listdir(path)

for file in file_name:
    if '.csv' in file and not os.path.exists(path + 'csv files/' + file):
        shutil.move(path + file, path + 'csv files/' + file)
    elif '.twb' in file and not os.path.exists(path + 'Tableau files/' + file):
        shutil.move(path + file, path + 'Tableau files/' + file)
    elif '.xlsx' in file and not os.path.exists(path + 'excel files/' + file):
        shutil.move(path + file, path + 'excel files/' + file)
    elif '.txt' in file and not os.path.exists(path + 'text files/' + file):
        shutil.move(path + file, path + 'text files/' + file)
    elif '.ssmssln' in file and not os.path.exists(path + 'SQL files/' + file):
        shutil.move(path + file, path + 'SQL files/' + file)
    else:
        print('This file is not included')
        
```

    This file is not included
    This file is not included
    This file is not included
    This file is not included
    This file is not included
    This file is not included
    


```python

```


```python

```
