import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import getIndustryPicklistValues from '@salesforce/apex/AccountController.getIndustryPicklistValues';
import getRatingPicklistValues from '@salesforce/apex/AccountController.getRatingPicklistValues';

export default class AccountList extends LightningElement {
    // Filter properties
    @track searchKey = '';
    @track industry = '';
    @track rating = '';
    @track minRevenue;
    @track maxRevenue;

    // Picklist options
    @track industryOptions = [];
    @track ratingOptions = [];

    // Data table properties
    @track sortedBy = 'Name';
    @track sortedDirection = 'asc';
    
    // Loading state
    isLoading = false;

    // Define columns for the data table
    columns = [
        { 
            label: 'Account Name', 
            fieldName: 'Name', 
            type: 'text', 
            sortable: true 
        },
        { 
            label: 'Industry', 
            fieldName: 'Industry', 
            type: 'text', 
            sortable: true 
        },
        { 
            label: 'Rating', 
            fieldName: 'Rating', 
            type: 'text', 
            sortable: true 
        },
        { 
            label: 'Type', 
            fieldName: 'Type', 
            type: 'text', 
            sortable: true 
        },
        { 
            label: 'Phone', 
            fieldName: 'Phone', 
            type: 'phone' 
        },
        { 
            label: 'Website', 
            fieldName: 'Website', 
            type: 'url' 
        },
        { 
            label: 'Annual Revenue', 
            fieldName: 'AnnualRevenue', 
            type: 'currency', 
            sortable: true,
            cellAttributes: { alignment: 'left' }
        },
        { 
            label: 'Employees', 
            fieldName: 'NumberOfEmployees', 
            type: 'number', 
            sortable: true 
        }
    ];

    // Wire service to get accounts with reactive parameters
    @wire(getAccounts, { 
        searchKey: '$searchKey',
        industry: '$industry',
        rating: '$rating',
        minRevenue: '$minRevenue',
        maxRevenue: '$maxRevenue'
    })
    accounts;

    // Wire service to get industry picklist values
    @wire(getIndustryPicklistValues)
    wiredIndustries({ error, data }) {
        if (data) {
            this.industryOptions = data.map(option => ({
                label: option.label,
                value: option.value
            }));
        } else if (error) {
            this.showErrorToast('Error loading industries', error.body.message);
        }
    }

    // Wire service to get rating picklist values
    @wire(getRatingPicklistValues)
    wiredRatings({ error, data }) {
        if (data) {
            this.ratingOptions = data.map(option => ({
                label: option.label,
                value: option.value
            }));
        } else if (error) {
            this.showErrorToast('Error loading ratings', error.body.message);
        }
    }

    // Computed property to show "no records" message
    get showNoRecords() {
        return this.accounts.data && this.accounts.data.length === 0;
    }

    // Event handlers for filter changes
    handleSearchKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleIndustryChange(event) {
        this.industry = event.detail.value;
    }

    handleRatingChange(event) {
        this.rating = event.detail.value;
    }

    handleMinRevenueChange(event) {
        this.minRevenue = event.target.value ? parseFloat(event.target.value) : null;
    }

    handleMaxRevenueChange(event) {
        this.maxRevenue = event.target.value ? parseFloat(event.target.value) : null;
    }

    // Clear all filters
    handleClearFilters() {
        this.searchKey = '';
        this.industry = '';
        this.rating = '';
        this.minRevenue = null;
        this.maxRevenue = null;

        // Clear input field values
        const inputs = this.template.querySelectorAll('lightning-input, lightning-combobox');
        inputs.forEach(input => {
            input.value = '';
        });

        this.showSuccessToast('Filters cleared', 'All filters have been reset.');
    }

    // Handle column sorting
    handleSort(event) {
        const { fieldName, sortDirection } = event.detail;
        this.sortedBy = fieldName;
        this.sortedDirection = sortDirection;

        // Clone the data to avoid mutating the cached wire result
        const accountsCopy = [...this.accounts.data];
        
        // Sort the data
        accountsCopy.sort((a, b) => {
            let aValue = a[fieldName] || '';
            let bValue = b[fieldName] || '';

            // Handle different data types
            if (typeof aValue === 'string') {
                aValue = aValue.toLowerCase();
                bValue = bValue.toLowerCase();
            }

            if (sortDirection === 'asc') {
                return aValue > bValue ? 1 : -1;
            } else {
                return aValue < bValue ? 1 : -1;
            }
        });

        // Update the data with sorted values
        this.accounts = { ...this.accounts, data: accountsCopy };
    }

    // Toast notification helpers
    showSuccessToast(title, message) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: 'success'
            })
        );
    }

    showErrorToast(title, message) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: 'error',
                mode: 'sticky'
            })
        );
    }
}