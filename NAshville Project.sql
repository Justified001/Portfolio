SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
      ,[SalesDates]
  FROM [Project Portfolio02].[dbo].[Nashville Housing Project]

  SELECT *
  FROM [Project Portfolio02].dbo.[Nashville Housing Project]

  -- standardise Date format

  Alter Table [Nashville Housing Project]
 Add [SaleDateConverted] Date;

 update [Nashville Housing Project]
 Set [SaleDateConverted] = convert(Date, SaleDate)


  SELECT [SaleDateConverted], convert(Date, SaleDate)
 FROM [Project Portfolio02].dbo.[Nashville Housing Project]

 --Populating Property address data
 Select UniqueID, ParcelID, PropertyAddress, SaleDateConverted
 FROM [Project Portfolio02].dbo.[Nashville Housing Project]
 
 Select a.ParcelID, b.ParcelID, a.PropertyAddress, b.PropertyAddress
 FROM [Project Portfolio02].dbo.[Nashville Housing Project] a
 JOIN [Project Portfolio02].dbo.[Nashville Housing Project] b
		on a.ParcelID = b.ParcelID
		and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

		--populate the null value in a.ProprtyAddress in our table

Select a.ParcelID, b.ParcelID, a.PropertyAddress, b.PropertyAddress, 
		isnull(a.PropertyAddress, b.PropertyAddress) AS [Property Address Populated]
 FROM [Project Portfolio02].dbo.[Nashville Housing Project] a
 JOIN [Project Portfolio02].dbo.[Nashville Housing Project] b
		on a.ParcelID = b.ParcelID
		and a.[UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress is null

		--Fianl Table Update command for Property address Population
Update a
Set propertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
FROM [Project Portfolio02].dbo.[Nashville Housing Project] a
 JOIN [Project Portfolio02].dbo.[Nashville Housing Project] b
		on a.ParcelID = b.ParcelID
		and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Spliting the Address Column

Select
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) As Address,
    SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) As Address2
FROM [Project Portfolio02].dbo.[Nashville Housing Project]


--Add columns  for city and property address seperately

Alter Table [Project Portfolio02].dbo.[Nashville Housing Project]
 Add [property Address Location] nVarchar(255);

 update [Project Portfolio02].dbo.[Nashville Housing Project]
 Set [property Address Location] = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)


 Alter Table [Project Portfolio02].dbo.[Nashville Housing Project]
 Add [Property Address City] nVarchar(255);
 
 update [Project Portfolio02].dbo.[Nashville Housing Project]
 Set [Property Address City] = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))




 --Separating Owners Address into different column using PARSENAME

 SELECT 
 PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS [Owner's Address],
 PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS [Owner's City],
 PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS [Owner's State]
 FROM [Project Portfolio02].dbo.[Nashville Housing Project]



 -- Add Column for Onwer's Address, City and State Separately

 Alter Table [Project Portfolio02].dbo.[Nashville Housing Project]
 Add [Owner's Address] nVarchar(255);

 update [Project Portfolio02].dbo.[Nashville Housing Project]
 Set [Owner's Address] = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

 Alter Table [Project Portfolio02].dbo.[Nashville Housing Project]
 Add [Owner's City] nVarchar(255);

 update [Project Portfolio02].dbo.[Nashville Housing Project]
 Set [Owner's City] =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

 Alter Table [Project Portfolio02].dbo.[Nashville Housing Project]
 Add [Owner's State] nVarchar(255);

 update [Project Portfolio02].dbo.[Nashville Housing Project]
 Set [Owner's State] =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

 SELECT *
FROM [Project Portfolio02].dbo.[Nashville Housing Project]


-- Change Y and N in Sold as vacant to Yes and No

Select Soldasvacant,
	Case When Soldasvacant = 'Y' THEN 'Yes'
		 When Soldasvacant = 'n' THEN 'No'
		 ELSE SOldasvacant
		 END
From [Project Portfolio02].dbo.[Nashville Housing Project]

-- Table Update

 UPDATE [Project Portfolio02].dbo.[Nashville Housing Project]
 SET SoldAsVacant = Case When Soldasvacant = 'Y' THEN 'Yes'
					When Soldasvacant = 'n' THEN 'No'
					 ELSE SOldasvacant
					 END

-- Check your data 
 SELECT Distinct(Soldasvacant), Count(Soldasvacant)
 FROM [Project Portfolio02].dbo.[Nashville Housing Project]
 GROUP BY Soldasvacant
 ORDER BY 2

 -- Remove Duplicate
		-- CREATING A TEMP TAVLE TO SELECT THE DUPLICATE
WITH ROWNUMCTE AS (
	SELECT *, Row_Number() Over(Partition BY ParcelID,
											PropertyAddress,
											SalePrice,
											SaleDate,
											LegalReference
											ORDER BY UniqueID
											) row_num
FROM [Project Portfolio02].dbo.[Nashville Housing Project]
--ORDER BY ParcelID
	)
SELECT *
FROM ROWNUMCTE
WHERE row_num > 1

		--Delete the Duplicate using the temp table 

WITH ROWNUMCTE AS (
	SELECT *, Row_Number() Over(Partition BY ParcelID,
											PropertyAddress,
											SalePrice,
											SaleDate,
											LegalReference
											ORDER BY UniqueID
											) row_num
FROM [Project Portfolio02].dbo.[Nashville Housing Project]
--ORDER BY ParcelID
	)
Delete
FROM ROWNUMCTE
WHERE row_num > 1

	-- View Table after deleting the duplicates

	WITH ROWNUMCTE AS (
	SELECT *, Row_Number() Over(Partition BY ParcelID,
											PropertyAddress,
											SalePrice,
											SaleDate,
											LegalReference
											ORDER BY UniqueID
											) row_num
FROM [Project Portfolio02].dbo.[Nashville Housing Project]
--ORDER BY ParcelID
	)
SELECT *
FROM ROWNUMCTE
WHERE row_num > 1

 -- Delete unuseful column 

 SELECT *
 FROM [Project Portfolio02].dbo.[Nashville Housing Project]

 ALTER Table [Project Portfolio02].dbo.[Nashville Housing Project]
 DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress,
			saleDate, SalesDates

