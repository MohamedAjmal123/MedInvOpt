import pandas as pd
import numpy as np
from scipy.stats import skew 
import seaborn as sns
import matplotlib.pyplot as plt

data = pd.read_csv("C:\\Users\moham\Downloads\Data Set (6)\SAMPLEMIODATA.csv")
print(data)

data.dtypes

data.info()

data.isna().sum()

data.boxplot()

# PLOTTING
data['TQty'].plot.box()

data['UCPwithoutGST'].plot.box()

data['PurGSTPer'].plot.box()

data['MRP'].plot.box()

data['TotalCost'].plot.box()

data['NetSales'].plot.box()

data['ReturnMRP'].plot.box()

# FIRST AND SECOND BUSSINESS MOVEMENT
data.duplicated().sum()

data.describe()

data.describe(include = "all")

data.TQty.median()

data.TQty.mode()

data.TQty.var()

data.TQty.std()

data.UCPwithoutGST.median()

data.UCPwithoutGST.mode()

data.UCPwithoutGST.var()

data.UCPwithoutGST.std()

data.PurGSTPer.median()

data.PurGSTPer.mode()

data.PurGSTPer.var()

data.PurGSTPer.std()

data.MRP.median()

data.MRP.mode()

data.MRP.var()

data.MRP.std()

data.TotalCost.median()

data.TotalCost.mode()

data.TotalCost.var()

data.TotalCost.std()

data.TotalDiscount.median()

data.TotalDiscount.mode()

data.TotalDiscount.var()

data.TotalDiscount.std()

data.NetSales.median()

data.NetSales.mode()

data.NetSales.var()

data.NetSales.std()

data.ReturnMRP.median()

data.ReturnMRP.mode()

data.ReturnMRP.var()

data.ReturnMRP.std()

#THIRD BUSINESS MOMENT

data.TQty.skew()

data.UCPwithoutGST.skew()

data.PurGSTPer.skew()

data.MRP.skew()

data.TotalCost.skew()

data.NetSales.skew()

data.ReturnMRP.skew()

#FOURTH BUSINESS MOMENT
data.TQty.kurt()

data.UCPwithoutGST.kurt()

data.PurGSTPer.kurt()

data.MRP.kurt()

data.TotalCost.kurt()

data.NetSales.kurt()

data.ReturnMRP.kurt()


# IQR 
#TQty
Q1 = np.percentile(data['TQty'], 25)
Q3 = np.percentile(data['TQty'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

r = data['TQty']
outliers = r[(r < lower_bound) | (r > upper_bound)]
print (outliers)

total_outliers = len(outliers)
print (total_outliers)

percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)


# UCPwithoutGST
Q1 = np.percentile(data['UCPwithoutGST'], 25)
Q3 = np.percentile(data['UCPwithoutGST'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

s = data['UCPwithoutGST']
outliers = s[(s < lower_bound) | (s > upper_bound)]
print (outliers)

total_outliers = len(outliers)
print (total_outliers)

percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)


# PurGSTPer
Q1 = np.percentile(data['PurGSTPer'], 25)
Q3 = np.percentile(data['PurGSTPer'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

t= data['PurGSTPer']
outliers = t[(t < lower_bound) | (t > upper_bound)]
print (outliers)

total_outliers = len(outliers)
print (total_outliers)

percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)


# MRP
Q1 = np.percentile(data['MRP'], 25)
Q3 = np.percentile(data['MRP'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

u = data['MRP']
outliers = u[(u < lower_bound) | (u > upper_bound)]
print (outliers)

total_outliers = len(outliers)
print (total_outliers)

percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)


# TotalCost

Q1 = np.percentile(data['TotalCost'], 25)
Q3 = np.percentile(data['TotalCost'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

v = data['TotalCost']
outliers = v[(v < lower_bound) | (v > upper_bound)]
print (outliers)

total_outliers = len(outliers)
print (total_outliers)

percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)

# NetSales

Q1 = np.percentile(data['NetSales'], 25)
Q3 = np.percentile(data['NetSales'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

w = data['NetSales']
outliers = w[(w < lower_bound) | (w > upper_bound)]
print (outliers)

total_outliers = len(outliers)
print (total_outliers)

percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)

# ReturnMRP

Q1 = np.percentile(data['ReturnMRP'], 25)
Q3 = np.percentile(data['ReturnMRP'], 75)
print (Q1)
print(Q3)

IQR = Q3 - Q1
print (IQR)

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print (lower_bound)

print(upper_bound)

x = data['ReturnMRP']
outliers = x[(x < lower_bound) | (x > upper_bound)]
print (outliers)
total_outliers = len(outliers)
print (total_outliers)
percentage_outliers = (total_outliers/len(data))*100
print(percentage_outliers)


# trimming
#TQty
trimmed_data = data[(data['TQty'] >= lower_bound) & (data['TQty'] <= upper_bound)]
print (trimmed_data)

# UCPwithoutGST
trimmed_data= data[(data['UCPwithoutGST'] >= lower_bound) & (data['UCPwithoutGST'] <= upper_bound)]
print (trimmed_data)


#PurGSTPer
trimmed_data = data[(data['PurGSTPer'] >= lower_bound) & (data['PurGSTPer'] <= upper_bound)]
print(trimmed_data)

# MRP
trimmed_data = data[(data['MRP'] >= lower_bound) & (data['MRP'] <= upper_bound)]
print(trimmed_data)

# TotalCost
trimmed_data = data[(data['TotalCost'] >= lower_bound) & (data['TotalCost'] <= upper_bound)]
print(trimmed_data)

# NetSales
trimmed_data = data[(data['NetSales'] >= lower_bound) & (data['NetSales'] <= upper_bound)]
print(trimmed_data)

# ReturnMRP
trimmed_data = data[(data['ReturnMRP'] >= lower_bound) & (data['ReturnMRP'] <= upper_bound)]
print (trimmed_data)

print(trimmed_data)
