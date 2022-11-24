const host = 'https://preserve.lib.unb.ca'
describe('Preserve', {baseUrl: host, groups: ['sites']}, () => {

  const apla2018Url = `${host}/apla-2018/20191114182714/https://apla2018.lib.unb.ca/`
  context('APLA2018', {baseUrl: apla2018Url}, () => {
    const redirectUrl = 'https://apla2018.lib.unb.ca'  
    specify(`${redirectUrl} should redirect here`, () => {
      cy.shouldRedirect(redirectUrl, apla2018Url)
    })
  })
  
  const winslowUrl = `${host}/wayback/20141205152208/http://atlanticportal.hil.unb.ca/acva/en/winslow/family/index.php`
  context('The Winslows', {baseUrl: winslowUrl}, () => {
    specify('Title should contain "The Winslows"', () => {
      cy.visit(winslowUrl)
      cy.get('#second-navbar')
        .should('contain', 'The Winslows')
    })
  })
})
