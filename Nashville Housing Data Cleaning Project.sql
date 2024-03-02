--Cleaning Data in SQL Queries

Select*
From [Portfolio Project]..NashvilleHousing
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--Standarize Date Format
Select SaleDateConverted, Convert(Date,SaleDate)
From [Portfolio Project]..NashvilleHousing

--Update NashvilleHousing
--SET SaleDate = Convert(Date,SaleDate)
Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateconverted = Convert(Date,SaleDate)

---------------------------------------------------------------------------------------------------------------

--Populate Property Adress data

Select *
From [Portfolio Project]..NashvilleHousing
--Where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress, b.PropertyAddress)
From [Portfolio Project]..NashvilleHousing a
JOIN [Portfolio Project]..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
Set PropertyAddress = isnull(a.propertyaddress,b.PropertyAddress)
From [Portfolio Project]..NashvilleHousing a
JOIN [Portfolio Project]..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-----------------------------------------------------------------------------------------------------------------------------

--Breaking out Address into individual Columns (Address, City, State)
Select PropertyAddress
From [Portfolio Project]..NashvilleHousing

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(propertyAddress)) as Address
From [Portfolio Project].dbo.NashvilleHousing
--address
Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)
--city
Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(propertyAddress))



--OwnerAddress
Select OwnerAddress
From [Portfolio Project]..NashvilleHousing

Select
ParseName(Replace(OwnerAddress, ',', '.'), 3) as OwnerAddress
,ParseName(Replace(OwnerAddress, ',', '.'), 2) as OwnerCity
,ParseName(Replace(OwnerAddress, ',', '.'), 1) as OwnerState
From [Portfolio Project].dbo.NashvilleHousing



Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = ParseName(Replace(OwnerAddress, ',', '.'), 3)

Alter Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = ParseName(Replace(OwnerAddress, ',', '.'), 2)

Alter Table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = ParseName(Replace(OwnerAddress, ',', '.'), 1)

------------------------------------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "sold as Vacant" Field
Select Distinct(SOldAsVacant), Count(SoldAsVacant)
From [Portfolio Project]..NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant,
	Case When SoldAsVacant = 'Y' THEN 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End
From [Portfolio Project]..NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' THEN 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End

---------------------------------------------------------------------

--Remove Duplicates
WITH Row_numCTE AS (
Select *, 
	ROW_NUMBER() Over (
	Partition By ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order by
				UniqueID
				) row_num

From [Portfolio Project]..NashvilleHousing 
--order by ParcelID
)

--Delete
--From Row_numCTE
--Where row_num > 1
--order by PropertyAddress

--------------------------------------------------------------------------------------

--Delete Unused Columns

Select *
From [Portfolio Project]..NashvilleHousing

Alter Table [Portfolio Project]..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

