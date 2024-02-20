select*
From NashvilleHousing

select SaleDateConverted, CONVERT(date,saledate)
From NashvilleHousing

Update NashvilleHousing
SET Saledate = CONVERT(date,saledate)

ALTER TABLE NashvilleHousing
Add SaledateConverted date;

Update NashvilleHousing
SET SaledateConverted = CONVERT(date,saledate)


USE PortfolioProject
select propertyaddress
from NashvilleHousing

select *
From NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID =b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress IS NULL

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID =b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress IS NULL

Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX (',', PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX (',', PropertyAddress)+1, LEN(PropertyAddress)) as City
From NashvilleHousing 

ALTER TABLE NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress=SUBSTRING(PropertyAddress, 1, CHARINDEX ('', PropertyAddress)+1) 

ALTER TABLE NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX (' ', PropertyAddress)+1, LEN(PropertyAddress))

select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress =PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashvilleHousing
SET  OwnerSplitState =PARSENAME(REPLACE(OwnerAddress,',','.'),1)

select DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
From NashvilleHousing
Group By SoldAsVacant 
Order By 2

select SoldAsVacant
,CASE When SoldAsVacant = 'Y' THEN 'Yes'     
     When SoldAsVacant = 'N' THEN 'No'
	 Else SoldAsVacant
	 END 
	From NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant= CASE When SoldAsVacant='Y' THEN 'Yes'     
When SoldAsVacant='N' THEN 'No'
Else SoldAsVacant
END 


SELECT *,
Row_Number() OVER(
Partition by ParcelID,PropertyAddress,Saleprice,SaleDate,LegalReference ORDER BY UniqueID) Row_Num
From NashvilleHousing
Order by ParcelID

WITH RowNumCTE AS (
SELECT *,
Row_Number() OVER(
Partition by ParcelID,PropertyAddress,Saleprice,SaleDate,LegalReference ORDER BY UniqueID) Row_Num
From NashvilleHousing)


SELECT *
From RowNumCTE
WHERE Row_Num > 1
--order by PropertyAddress

SELECT*
From NashvilleHousing




