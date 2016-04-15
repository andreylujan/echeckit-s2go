
Organization.create!([
                       {name: "Playstation"}
])

Role.create!([
               {organization_id: 1, name: "Supervisor"},
               {organization_id: 1, name: "Promotor"}
])
User.create!([
               {email: "pablo.lluch@gmail.com",
                encrypted_password: "$2a$10$.ipOlZxRsAoMQVo0XNb5A.yKx1t01j4xShGxMitj4arhEU.df3E/C",
                reset_password_token: nil, reset_password_sent_at: nil,
                remember_created_at: nil, confirmation_token: nil,
                confirmed_at: nil, confirmation_sent_at: nil,
                unconfirmed_email: nil, rut: "17.085.953-7",
                first_name: "Pablo", last_name: "Lluch",
                phone_number: nil, address: nil,
                image: nil,
                role_id: 1,
                password: '11111111'
                }
])

d = Dealer.create!([
                     { name: "Ripley" },
                     { name: "Falabella" },
                     { name: "Costanera Center" }
])

r = Region.create!(
  name: "Región Metropolitana", ordinal: 13
)

zones = Zone.create!([
                       { name: "Zona Oriente", dealers: d, region: r },
                       { name: "Zona Centro", dealers: [ d[0]], region: r },
                       { name: "Zona Sur", dealers: [d[1], d[2]], region: r }
])

Store.create!([
                { dealer: d[0], zone: zones[0], name: "Microplay" },
                { dealer: d[0], zone: zones[0], name: "PCFactory" },
                { dealer: d[1], zone: zones[1], name: "Zmart" },
                { dealer: d[2], zone: zones[2], name: "Microplay" }
])

SectionType.create!([
                      { name: "location" },
                      { name: "data" },
                      { name: "gallery" }
])

Section.create!([
                  {
                    organization_id: 1,
                    name: "Ubicación",
                    section_type_id: 1
                  },
                  {
                    organization_id: 1,
                    name: "Checklists comercial",
                    section_type_id: 2,
                    subsections: [
                      Subsection.create!(name: "Protocolo",
                                         data_parts: [
                                          Checklist.create!(name: "Protocolo"),
                                          Comment.create!(name: "Observación")
                            
                      ]),
                      
                      Subsection.create!(name: "Kit Punto de venta",
                                         data_parts: [
                                          Checklist.create!(name: "Kit punto de venta"),
                                          Gallery.create!(name: "Fotos kit punto de venta")
                      ])
                    ]
                  },
                  {
                    organization_id: 1,
                    name: "Productos",
                    section_type_id: 2
                  },
                  {
                    organization_id: 1,
                    name: "Galería",
                    section_type_id: 3
                  }
])

Checklist.first.children.create!([
  { 
    name: "Limpieza y orden",
    type: "ChecklistItem" 
  },
    {
      name: "Encendido de interactivo",
      type: "ChecklistItem"
    }
])

Checklist.second.children.create!([
  { 
    name: "Foco Visible",
    type: "ChecklistItem" 
  },
    {
      name: "Interactivo PS4",
      type: "ChecklistItem"
    },
    {
      name: "Muebles PS4",
      type: "ChecklistItem"
    }
])

ReportType.create! name: "Reporte Diario", organization_id: 1
platforms = Platform.create!([
  { organization: Organization.last, name: "Playstation 4" },
  { organization: Organization.last, name: "Xbox 360" },
  { organization: Organization.last, name: "Wii U" },
  { organization: Organization.last, name: "PC" },
  { organization: Organization.last, name: "Playstation 3" },
  { organization: Organization.last, name: "Xbox One" }
])

TopList.create! organization: Organization.last, top_list_items: [
  TopListItem.create!(images: [ 
    'http://charlieintel.com/wp-content/uploads/2015/04/image1.jpg',
    "https://vgboxart.com/boxes/PS4/72885-call-of-duty-black-ops-iii.png" ], 
    name: "Call of Duty: Black Ops III",
    platforms: [ platforms[0], platforms[1], platforms[4], platforms[4] ]
    ),
  TopListItem.create!(images: [ 'http://images.pushsquare.com/games/ps4/lego_marvel_super_heroes/cover_large.jpg',
    'http://40.media.tumblr.com/0a933e16f3c7a1ab10c21904ed9dae19/tumblr_mxnsguv8Rw1qzwtdlo1_1280.jpg'],
    name: "Lego Marvel Super Heroes",
    platforms: [ platforms[0], platforms[1], platforms[2], platforms[3], platforms[4] ]
)
]
