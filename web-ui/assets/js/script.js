// Navigation and utility functions
document.addEventListener('DOMContentLoaded', function() {
    // Initialize navigation
    initNavigation();
    
    // Set active navigation link
    setActiveNavLink();
    
    // Initialize form handlers
    initFormHandlers();
});

function initNavigation() {
    const navLinks = document.querySelectorAll('.nav-links a');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            // Allow default navigation
        });
    });
}

function setActiveNavLink() {
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.nav-links a');
    
    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage || (currentPage === '' && href === 'index.html')) {
            link.style.opacity = '0.8';
            link.style.borderBottom = '2px solid white';
            link.style.paddingBottom = '0.5rem';
        }
    });
}

function initFormHandlers() {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            handleFormSubmit(form);
        });
    });
    
    // Initialize reset buttons
    const resetButtons = document.querySelectorAll('.btn-reset, [type="reset"]');
    resetButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            const form = this.closest('form');
            if (form) {
                form.reset();
            }
        });
    });
}

function handleFormSubmit(form) {
    // Collect form data
    const formData = new FormData(form);
    const data = Object.fromEntries(formData);
    
    // Show success message
    const message = document.createElement('div');
    message.className = 'alert alert-success';
    message.textContent = 'Form submitted successfully!';
    
    const firstElement = form.parentNode.firstChild;
    form.parentNode.insertBefore(message, firstElement);
    
    // Scroll to message
    message.scrollIntoView({ behavior: 'smooth' });
    
    // Remove message after 5 seconds
    setTimeout(() => {
        message.remove();
    }, 5000);
    
    console.log('Form Data:', data);
}

// Search functionality
function searchForms(query) {
    const cards = document.querySelectorAll('.card');
    const lowerQuery = query.toLowerCase();
    
    cards.forEach(card => {
        const text = card.textContent.toLowerCase();
        if (text.includes(lowerQuery)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

// Table sort functionality
function sortTable(columnIndex) {
    const table = document.querySelector('table');
    if (!table) return;
    
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    rows.sort((a, b) => {
        const aVal = a.cells[columnIndex].textContent.trim();
        const bVal = b.cells[columnIndex].textContent.trim();
        
        // Try to parse as numbers
        const aNum = parseFloat(aVal);
        const bNum = parseFloat(bVal);
        
        if (!isNaN(aNum) && !isNaN(bNum)) {
            return aNum - bNum;
        }
        
        return aVal.localeCompare(bVal);
    });
    
    rows.forEach(row => tbody.appendChild(row));
}

// Utility: Format date
function formatDate(date) {
    const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
    return new Date(date).toLocaleDateString('en-US', options);
}

// Utility: Validate email
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Utility: Show notification
function showNotification(message, type = 'info') {
    const container = document.querySelector('.form-container') || document.body;
    
    const notification = document.createElement('div');
    notification.className = `alert alert-${type}`;
    notification.textContent = message;
    
    container.insertBefore(notification, container.firstChild);
    
    setTimeout(() => {
        notification.remove();
    }, 5000);
}

// Export/Download functionality
function downloadTableAsCSV(filename = 'export.csv') {
    const table = document.querySelector('table');
    if (!table) {
        showNotification('No table found to export', 'warning');
        return;
    }
    
    let csv = [];
    const rows = table.querySelectorAll('tr');
    
    rows.forEach(row => {
        const cols = row.querySelectorAll('td, th');
        const csvRow = Array.from(cols).map(col => '"' + col.textContent.trim() + '"').join(',');
        csv.push(csvRow);
    });
    
    const csvContent = 'data:text/csv;charset=utf-8,' + encodeURI(csv.join('\n'));
    const link = document.createElement('a');
    link.setAttribute('href', csvContent);
    link.setAttribute('download', filename);
    link.click();
}

// Print functionality
function printPage() {
    window.print();
}

// Modal functionality
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'block';
    }
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'none';
    }
}

// Close modal when clicking outside
window.addEventListener('click', function(event) {
    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
});

// Local storage utilities
const storage = {
    set: function(key, value) {
        localStorage.setItem(key, JSON.stringify(value));
    },
    get: function(key) {
        const item = localStorage.getItem(key);
        return item ? JSON.parse(item) : null;
    },
    remove: function(key) {
        localStorage.removeItem(key);
    },
    clear: function() {
        localStorage.clear();
    }
};

// Example: Save form data to localStorage
function autoSaveFormData(formId) {
    const form = document.getElementById(formId);
    if (!form) return;
    
    form.addEventListener('change', function() {
        const formData = new FormData(form);
        const data = Object.fromEntries(formData);
        storage.set(formId + '_data', data);
    });
    
    // Restore saved data
    const savedData = storage.get(formId + '_data');
    if (savedData) {
        Object.keys(savedData).forEach(key => {
            const field = form.querySelector(`[name="${key}"]`);
            if (field) {
                field.value = savedData[key];
            }
        });
    }
}
