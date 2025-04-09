ClassicEditor
    .create(document.querySelector('#editor'), {
        toolbar: {
            items: [
                'heading', '|',
                'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|',
                'blockQuote', 'insertTable', 'undo', 'redo'
            ]
        },
        table: {
            contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells']
        }
    })
    .then(editor => {
        editor.ui.view.editable.element.style.height = "200px";
    })
    .catch(error => {
        console.error(error);
    });